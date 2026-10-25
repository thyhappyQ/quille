extends Node

const SETTINGS_PATH = "settings.json"
const CONFIG_PATH = "config/"

var settings: Dictionary = {}

func _ready() -> void:
    load_config()
    print("Auto-Jump:",settings.get("auto_jump"))

func get_config(file_name:String)->String:
    return CONFIG_PATH + file_name

func load_config()->void:
    var setting_path = get_config(SETTINGS_PATH)
    if not FileAccess.file_exists(setting_path):
        print("Failed to access the settings file:",setting_path)
        return
    var setting_file = FileAccess.open(setting_path,FileAccess.READ)
    if not setting_file:
        print("Failed to open the setting file")
        return
    var setting_json_str = setting_file.get_as_text()
    setting_file.close()
    var setting_json = JSON.new()
    var setting_json_err = setting_json.parse(setting_json_str)
    if setting_json_err == null:
        print("Failed to parse the setting file")
        return
    else:
        settings = setting_json.data