#include <pebble.h>

static Window *window;
static TextLayer *title_text_layer;
static TextLayer *text_layer;
static TextLayer *lbl_cal_text_layer;
static char kcalstring[100];

//================================================================================
enum {
    KEY_BUTTON_EVENT = 0x0,
    BUTTON_EVENT_UP = 0x1,
    BUTTON_EVENT_DOWN = 0x2,
    BUTTON_EVENT_SELECT = 0x3,
    KEY_VIBRATION = 0x4,
    MESSAGE_KEY = 0x5,

    KCAL_KEY = 0x7
};
void process_tuple(Tuple *t)
{
    //Get key
    int key = t->key;

    //Decide what to do
    switch(key) {
        case KEY_BUTTON_EVENT: 
            //get value
            text_layer_set_text(text_layer, t->value->cstring);
            persist_write_string(KCAL_KEY,t->value->cstring);
            vibes_double_pulse();
            break;
        case KEY_VIBRATION:
            vibes_double_pulse();
            break;
            
    }
}
static void in_received_handler(DictionaryIterator *iter, void *context)
{
    
    //Get data
    Tuple *t = dict_read_first(iter);
    if(t)
    {
        process_tuple(t);
    }
    
    //Get next
    while(t != NULL)
    {
        t = dict_read_next(iter);
        if(t)
        {
            process_tuple(t);
        }
    }
}

//================================================================================
static void select_click_handler(ClickRecognizerRef recognizer, void *context) {
    text_layer_set_text(text_layer, "Select");
}

static void up_click_handler(ClickRecognizerRef recognizer, void *context) {
    text_layer_set_text(text_layer, "Up");
}

static void down_click_handler(ClickRecognizerRef recognizer, void *context) {
    text_layer_set_text(text_layer, "Down");
    vibes_double_pulse();
}

static void click_config_provider(void *context) {
    //window_single_click_subscribe(BUTTON_ID_SELECT, select_click_handler);
    //window_single_click_subscribe(BUTTON_ID_UP, up_click_handler);
    //window_single_click_subscribe(BUTTON_ID_DOWN, down_click_handler);
}

static void window_load(Window *window) {

    /*Receive message code here*/
    Layer *window_layer = window_get_root_layer(window);
    GRect bounds = layer_get_bounds(window_layer);
    
    //x,y,width, height
    title_text_layer = text_layer_create(GRect(0,10, 144, 40));
    text_layer = text_layer_create(GRect(0,50, 144, 80));
    lbl_cal_text_layer = text_layer_create(GRect(0,100, 144, 40));
    
    text_layer_set_text(title_text_layer, "MindFull for Pebble.");
    
    persist_read_string(KCAL_KEY, kcalstring,100);
    text_layer_set_text(text_layer, kcalstring);
    text_layer_set_text(lbl_cal_text_layer, "kcal");
    
    text_layer_set_font(text_layer, fonts_get_system_font(FONT_KEY_BITHAM_42_BOLD));
    text_layer_set_font(lbl_cal_text_layer, fonts_get_system_font(FONT_KEY_GOTHIC_24_BOLD));
    text_layer_set_overflow_mode(text_layer, GTextOverflowModeWordWrap);
    
    text_layer_set_text_alignment(title_text_layer, GTextAlignmentCenter);
    text_layer_set_text_alignment(text_layer, GTextAlignmentCenter);
    text_layer_set_text_alignment(lbl_cal_text_layer, GTextAlignmentCenter);
    
    layer_add_child(window_layer, text_layer_get_layer(title_text_layer));
    layer_add_child(window_layer, text_layer_get_layer(text_layer));
    layer_add_child(window_layer, text_layer_get_layer(lbl_cal_text_layer));
}

static void window_unload(Window *window) {
    text_layer_destroy(text_layer);
}

static void init(void) {

    

    window = window_create();
    window_set_click_config_provider(window, click_config_provider);
    window_set_window_handlers(window, (WindowHandlers) {
        .load = window_load,
        .unload = window_unload,
    });
    const bool animated = true;
    
    //==================================================================
    //Register AppMessage events
    app_message_register_inbox_received(in_received_handler);
    app_message_open(512, 512);    //Large input and output buffer sizes
    //==================================================================
    window_stack_push(window, animated);
    
}

static void deinit(void) {
    window_destroy(window);
}

int main(void) {
    init();
    APP_LOG(APP_LOG_LEVEL_DEBUG, "Done initializing, pushed window: %p", window);   
    app_event_loop();
    deinit();
}
