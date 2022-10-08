#include "ruby.h"

// NOTE: UNFISHISHED. Was slower than array so abandoned.
typedef struct struct_doubly_linked_list_node {
  VALUE value;
  struct struct_doubly_linked_list_node *prev;
  struct struct_doubly_linked_list_node *next;
} doubly_linked_list_node;

typedef struct {
  unsigned int size;
  doubly_linked_list_node *head;
  doubly_linked_list_node *tail;
} doubly_linked_list;

void free_nodes(doubly_linked_list_node *node) {
  doubly_linked_list_node *next;
  while (node) {
    next = node->next;
    xfree(node);
    node = next;
  }
  return;
}

void clear_doubly_linked_list(doubly_linked_list *a_doubly_linked_list) {
  if (a_doubly_linked_list->head)
    free_nodes(a_doubly_linked_list->head);
  a_doubly_linked_list->size = 0;
  a_doubly_linked_list->head = NULL;
  a_doubly_linked_list->tail = NULL;
  return;
}

static doubly_linked_list *get_doubly_linked_list_from_self(VALUE self) {
  doubly_linked_list *a_doubly_linked_list;
  Data_Get_Struct(self, doubly_linked_list, a_doubly_linked_list);
  return a_doubly_linked_list;
}

static doubly_linked_list *create_doubly_linked_list() {
  doubly_linked_list *a_doubly_linked_list = ALLOC(doubly_linked_list);
  a_doubly_linked_list->size = 0;
  a_doubly_linked_list->head = NULL;
  a_doubly_linked_list->tail = NULL;
  return a_doubly_linked_list;
}

static doubly_linked_list_node *create_node(VALUE obj) {
  doubly_linked_list_node *node = ALLOC(doubly_linked_list_node);
  node->value = obj;
  node->prev = NULL;
  node->next = NULL;
  return node;
}

static void doubly_linked_list_mark(void *ptr) {
  if (ptr) {
    doubly_linked_list *doubly_linked_list = ptr;
    doubly_linked_list_node *node = doubly_linked_list->head;
    while (node) {
      rb_gc_mark(node->value);
      node = node->next;
    }
  }
}

static void doubly_linked_list_free(void *ptr) {
  if (ptr) {
    doubly_linked_list *doubly_linked_list = ptr;
    free_nodes(doubly_linked_list->head);
    xfree(doubly_linked_list);
  }
}

static VALUE doubly_linked_list_alloc(VALUE klass) {
  doubly_linked_list *doubly_linked_list = create_doubly_linked_list();
  return Data_Wrap_Struct(klass, doubly_linked_list_mark,
                          doubly_linked_list_free, doubly_linked_list);
}

static VALUE doubly_linked_list_push_front(VALUE self, VALUE obj) {
  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  doubly_linked_list_node *node = create_node(obj);
  if (doubly_linked_list->head) {
    node->next = doubly_linked_list->head;
    doubly_linked_list->head->prev = node;
    doubly_linked_list->head = node;
  } else {
    doubly_linked_list->head = node;
    doubly_linked_list->tail = node;
  }
  doubly_linked_list->size++;
  return obj;
}

static VALUE doubly_linked_list_push_back(VALUE self, VALUE obj) {
  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  doubly_linked_list_node *node = create_node(obj);
  if (doubly_linked_list->tail) {
    node->prev = doubly_linked_list->tail;
    doubly_linked_list->tail->next = node;
    doubly_linked_list->tail = node;
  } else {
    doubly_linked_list->head = node;
    doubly_linked_list->tail = node;
  }
  doubly_linked_list->size++;
  return obj;
}

static VALUE doubly_linked_list_pop_front(VALUE self) {
  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  VALUE obj;
  if (!doubly_linked_list->head)
    return Qnil;
  doubly_linked_list_node *node = doubly_linked_list->head;
  obj = node->value;
  if (doubly_linked_list->size == 1) {
    clear_doubly_linked_list(doubly_linked_list);
    return obj;
  }
  doubly_linked_list->head->next->prev = NULL;
  doubly_linked_list->head = doubly_linked_list->head->next;
  doubly_linked_list->size--;
  return obj;
}

static VALUE doubly_linked_list_front(VALUE self) {
  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  if (doubly_linked_list->head)
    return doubly_linked_list->head->value;

  return Qnil;
}

static VALUE doubly_linked_list_back(VALUE self) {
  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  if (doubly_linked_list->tail)
    return doubly_linked_list->tail->value;

  return Qnil;
}

static VALUE doubly_linked_list_pop_back(VALUE self) {
  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  VALUE obj;
  if (!doubly_linked_list->tail)
    return Qnil;
  doubly_linked_list_node *node = doubly_linked_list->tail;
  obj = node->value;
  if (doubly_linked_list->size == 1) {
    clear_doubly_linked_list(doubly_linked_list);
    return obj;
  }
  doubly_linked_list->tail->prev->next = NULL;
  doubly_linked_list->tail = doubly_linked_list->tail->prev;
  doubly_linked_list->size--;
  return obj;
}

static VALUE doubly_linked_list_clear(VALUE self) {
  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  clear_doubly_linked_list(doubly_linked_list);
  return Qnil;
}

static VALUE doubly_linked_list_size(VALUE self) {
  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  return INT2NUM(doubly_linked_list->size);
}

static VALUE doubly_linked_list_is_empty(VALUE self) {
  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  return (doubly_linked_list->size == 0) ? Qtrue : Qfalse;
}

static VALUE doubly_linked_list_init(int argc, VALUE *argv, VALUE self) {
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
        doubly_linked_list_push_back(self, RARRAY_PTR(ary)[i]);
      }
    }
  }
  return self;
}

static VALUE doubly_linked_list_enum_length(VALUE self, VALUE args,
                                            VALUE eobj) {
  return doubly_linked_list_size(self);
}

static VALUE doubly_linked_list_each(VALUE self) {
  RETURN_SIZED_ENUMERATOR(self, 0, 0, doubly_linked_list_enum_length);

  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  doubly_linked_list_node *node = doubly_linked_list->head;
  while (node) {
    rb_yield(node->value);
    node = node->next;
  }
  return self;
}

static VALUE doubly_linked_list_reverse_each(VALUE self) {
  RETURN_SIZED_ENUMERATOR(self, 0, 0, doubly_linked_list_enum_length);

  doubly_linked_list *doubly_linked_list =
      get_doubly_linked_list_from_self(self);
  doubly_linked_list_node *node = doubly_linked_list->tail;
  while (node) {
    rb_yield(node->value);
    node = node->prev;
  }
  return self;
}

static VALUE c_doubly_linked_list;
static VALUE mDataStructures;

void Init_c_doubly_linked_list() {
  mDataStructures = rb_define_module("DataStructures");
  c_doubly_linked_list =
      rb_define_class_under(mDataStructures, "CDoublyLinkedList", rb_cObject);
  rb_define_alloc_func(c_doubly_linked_list, doubly_linked_list_alloc);
  rb_define_method(c_doubly_linked_list, "initialize", doubly_linked_list_init,
                   -1);
  rb_define_method(c_doubly_linked_list, "each", doubly_linked_list_each, 0);
  rb_define_method(c_doubly_linked_list, "reverse_each",
                   doubly_linked_list_reverse_each, 0);
  rb_define_method(c_doubly_linked_list, "<<", doubly_linked_list_push_back, 1);
  rb_define_method(c_doubly_linked_list, "shift", doubly_linked_list_push_front,
                   1);
  // rb_define_method(c_doubly_linked_list, "clear", doubly_linked_list_clear,
  // 0); rb_define_method(c_doubly_linked_list, "front",
  // doubly_linked_list_front, 0); rb_define_method(c_doubly_linked_list,
  // "back", doubly_linked_list_back, 0);
  rb_define_method(c_doubly_linked_list, "unshift",
                   doubly_linked_list_pop_front, 0);
  rb_define_method(c_doubly_linked_list, "pop", doubly_linked_list_pop_back, 0);
  // rb_define_method(c_doubly_linked_list, "size", doubly_linked_list_size, 0);
  // rb_define_alias(c_doubly_linked_list, "length", "size");
  // rb_define_method(c_doubly_linked_list, "empty?",
  // doubly_linked_list_is_empty,
  //                  0);
  rb_include_module(c_doubly_linked_list, rb_eval_string("Enumerable"));
}
