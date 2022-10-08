#include "ruby.h"

typedef struct struct_dll_node {
  VALUE obj;
  struct struct_dll_node *left;
  struct struct_dll_node *right;
} dll_node;

typedef struct {
  unsigned int size;
  dll_node *front;
  dll_node *back;
} dll;

void free_nodes(dll_node *node) {
  dll_node *next;
  while (node) {
    next = node->right;
    xfree(node);
    node = next;
  }
  return;
}

void clear_dll(dll *a_dll) {
  if (a_dll->front)
    free_nodes(a_dll->front);
  a_dll->size = 0;
  a_dll->front = NULL;
  a_dll->back = NULL;
  return;
}

static dll *get_dll_from_self(VALUE self) {
  dll *a_dll;
  Data_Get_Struct(self, dll, a_dll);
  return a_dll;
}

static dll *create_dll() {
  dll *a_dll = ALLOC(dll);
  a_dll->size = 0;
  a_dll->front = NULL;
  a_dll->back = NULL;
  return a_dll;
}

static dll_node *create_node(VALUE obj) {
  dll_node *node = ALLOC(dll_node);
  node->obj = obj;
  node->left = NULL;
  node->right = NULL;
  return node;
}

static void dll_mark(void *ptr) {
  if (ptr) {
    dll *dll = ptr;
    dll_node *node = dll->front;
    while (node) {
      rb_gc_mark(node->obj);
      node = node->right;
    }
  }
}

static void dll_free(void *ptr) {
  if (ptr) {
    dll *dll = ptr;
    free_nodes(dll->front);
    xfree(dll);
  }
}

static VALUE dll_alloc(VALUE klass) {
  dll *dll = create_dll();
  return Data_Wrap_Struct(klass, dll_mark, dll_free, dll);
}

static VALUE dll_push_front(VALUE self, VALUE obj) {
  dll *dll = get_dll_from_self(self);
  dll_node *node = create_node(obj);
  if (dll->front) {
    node->right = dll->front;
    dll->front->left = node;
    dll->front = node;
  } else {
    dll->front = node;
    dll->back = node;
  }
  dll->size++;
  return obj;
}

static VALUE dll_push_back(VALUE self, VALUE obj) {
  dll *dll = get_dll_from_self(self);
  dll_node *node = create_node(obj);
  if (dll->back) {
    node->left = dll->back;
    dll->back->right = node;
    dll->back = node;
  } else {
    dll->front = node;
    dll->back = node;
  }
  dll->size++;
  return obj;
}

static VALUE dll_pop_front(VALUE self) {
  dll *dll = get_dll_from_self(self);
  VALUE obj;
  if (!dll->front)
    return Qnil;
  dll_node *node = dll->front;
  obj = node->obj;
  if (dll->size == 1) {
    clear_dll(dll);
    return obj;
  }
  dll->front->right->left = NULL;
  dll->front = dll->front->right;
  dll->size--;
  return obj;
}

static VALUE dll_front(VALUE self) {
  dll *dll = get_dll_from_self(self);
  if (dll->front)
    return dll->front->obj;

  return Qnil;
}

static VALUE dll_back(VALUE self) {
  dll *dll = get_dll_from_self(self);
  if (dll->back)
    return dll->back->obj;

  return Qnil;
}

static VALUE dll_pop_back(VALUE self) {
  dll *dll = get_dll_from_self(self);
  VALUE obj;
  if (!dll->back)
    return Qnil;
  dll_node *node = dll->back;
  obj = node->obj;
  if (dll->size == 1) {
    clear_dll(dll);
    return obj;
  }
  dll->back->left->right = NULL;
  dll->back = dll->back->left;
  dll->size--;
  return obj;
}

static VALUE dll_clear(VALUE self) {
  dll *dll = get_dll_from_self(self);
  clear_dll(dll);
  return Qnil;
}

static VALUE dll_size(VALUE self) {
  dll *dll = get_dll_from_self(self);
  return INT2NUM(dll->size);
}

static VALUE dll_is_empty(VALUE self) {
  dll *dll = get_dll_from_self(self);
  return (dll->size == 0) ? Qtrue : Qfalse;
}

static VALUE dll_each_forward(VALUE self) {
  dll *dll = get_dll_from_self(self);
  dll_node *node = dll->front;
  while (node) {
    rb_yield(node->obj);
    node = node->right;
  }
  return self;
}

static VALUE dll_each_backward(VALUE self) {
  dll *dll = get_dll_from_self(self);
  dll_node *node = dll->back;
  while (node) {
    rb_yield(node->obj);
    node = node->left;
  }
  return self;
}

static VALUE dll_init(int argc, VALUE *argv, VALUE self) {
  long len, i;
  VALUE ary;

  if (argc == 0) {
    return self;
  } else if (argc > 1) {
    rb_raise(rb_eArgError, "wrong number of arguments");
  } else {
    ary = rb_check_array_type(argv[0]);
    if (!NIL_P(ary)) {
      len = RARRAY_LEN(ary);
      for (i = 0; i < len; i++) {
        dll_push_back(self, RARRAY_PTR(ary)[i]);
      }
    }
  }
  return self;
}

static VALUE c_doubly_linked_list;
static VALUE mDataStructures;

void Init_Cdll() {
  mDataStructures = rb_define_module("DataStructures");
  c_doubly_linked_list =
      rb_define_class_under(mDataStructures, "CDoublyLinkedList", rb_cObject);
  rb_define_alloc_func(c_doubly_linked_list, dll_alloc);
  rb_define_method(c_doubly_linked_list, "initialize", dll_init, -1);
  rb_define_method(c_doubly_linked_list, "push_front", dll_push_front, 1);
  rb_define_method(c_doubly_linked_list, "push_back", dll_push_back, 1);
  rb_define_method(c_doubly_linked_list, "clear", dll_clear, 0);
  rb_define_method(c_doubly_linked_list, "front", dll_front, 0);
  rb_define_method(c_doubly_linked_list, "back", dll_back, 0);
  rb_define_method(c_doubly_linked_list, "pop_front", dll_pop_front, 0);
  rb_define_method(c_doubly_linked_list, "pop_back", dll_pop_back, 0);
  rb_define_method(c_doubly_linked_list, "size", dll_size, 0);
  rb_define_alias(c_doubly_linked_list, "length", "size");
  rb_define_method(c_doubly_linked_list, "empty?", dll_is_empty, 0);
  rb_define_method(c_doubly_linked_list, "each_forward", dll_each_forward, 0);
  rb_define_method(c_doubly_linked_list, "each_backward", dll_each_backward, 0);
  rb_define_alias(c_doubly_linked_list, "each", "each_forward");
  rb_define_alias(c_doubly_linked_list, "reverse_each", "each_backward");
  rb_include_module(c_doubly_linked_list, rb_eval_string("Enumerable"));
}
