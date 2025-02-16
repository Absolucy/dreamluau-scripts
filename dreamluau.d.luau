export type TypePath = string
export type Proc = (...any) -> ...any
export type BooleanLike = number

declare class Weakref
	function resolve(self): ByondObject?
end

type Table<K, V> = { [K]: V }
type NamedTable<T> = Table<string, T>
type Array<T> = Table<number, T>
type AnyTable = Table<any, any>

type NamedByondList = NamedTable<ByondValue>
type ByondList = Table<ByondValue, ByondValue>
type ValueArray = Array<ByondValue>
type ObjectArray = Array<ByondObject>

export type ByondObject = NamedByondList
export type ByondValueNoProc = ByondObject | Proc | TypePath | string | number | nil | ByondList
export type ByondValue = ByondValueNoProc | Proc
export type SystemType = "MS Windows" | "UNIX"

export type ByondDist = number | string;

type ByondVars = NamedTable<ByondValueNoProc>

type LuaState = {
	display_name: string,
	internal_id: number,
	timer_enabled: BooleanLike,
	supress_runtimes: BooleanLike,
	functions_to_execute: Array<string>,
}

type DmWorld = {
	time: number,
	tick_usage: number,
	tick_lag: number,
	url: string,
	address: string?,
	port: number,
	view: ByondDist,
	system_type: SystemType,
	name: string,
	timeofday: number,
	realtime: number,
	timezone: number,
	byond_version: number,
	byond_nuild: number,
	cpu: number,
	icon_size: string | number,
	game_state: number,
	status: string,
	map_cpu: number,
	maxx: number,
	maxy: number,
	maxz: number,
} & ByondObject


type GlobalVars = {
	GLOB: {
		-- clients
		directory: NamedTable<ByondObject>,
		clients: Array<ByondObject>,

		-- mob lists
		mob_living_list: ObjectArray,
		mob_list: ObjectArray,
		player_list: ObjectArray,
		alive_player_list: ObjectArray,
		current_observers_list: ObjectArray,


		-- directions
		cardinals: Array<number>,
		cardinals_multiz: Array<number>,
		diagonals: Array<number>,
		diagonals_multiz: Array<number>,
		alldirs: Array<number>,
		alldirs_multiz: Array<number>,
		corners_multiz: Array<number>,
		cardinal_angles: NamedTable<number>,

		-- misc
		glide_size_multiplier: number,
		round_id: number,
	} & ByondVars
} & ByondVars

type SdqlWrappers = {
	-- math
	_abs: (number) -> number,
	_arccos: (number) -> number,
	_arcsin: (number) -> number,
	_cos: (number) -> number,
	_sin: (number) -> number,
	_log: (number, number) -> number,
	_min: (...number) -> number,
	_max: (...number) -> number,
	_round: (number, number?) -> number,
	_turn: (number, number) -> number,

	-- colors
	_rgb: (number, number, number) -> string,
	_rgba: (number, number, number, number) -> string,

	-- object stuff
	_locate: (number, number, number) -> ByondObject,
	_block: (ByondObject, ByondObject) -> ObjectArray,
	_range: (ByondDist, ByondObject?) -> ObjectArray,
	_view: (ByondDist, ByondObject?) -> ObjectArray,
	_oview: (ByondDist, ByondObject?) -> ObjectArray,
	_viewers: (ByondDist, ByondObject?) -> ObjectArray,
	_oviewers: (ByondDist, ByondObject?) -> ObjectArray,
	_hearers: (ByondDist, ByondObject?) -> ObjectArray,
	_ohearers: (ByondDist, ByondObject?) -> ObjectArray,
	_rect_turfs: (number, number, ByondObject) -> ObjectArray,

	-- regex
	_regex: (string, string?) -> ByondObject,
	_REGEX_QUOTE: (string) -> string,
	_REGEX_QUOTE_REPLACEMENT: (string) -> string,

	-- movement
	_step: (ByondObject, number) -> (),
	_step_rand: (ByondObject) -> (),
	_step_towards: (ByondObject, ByondObject) -> (),
	_step_away: (ByondObject, ByondObject, number?) -> (),
	_get_step: (ByondObject, number) -> ByondObject,
	_get_dist: (ByondObject, ByondObject) -> number,

	-- text
	_ascii2text: (string) -> number,
	_num2text: (number) -> string,
	_text2num: (string) -> number,
	_ckey: (string) -> string,
	_ckeyEx: (string) -> string,
	_copytext: (string, number?, number?) -> string,
	_findtext: (string, string | ByondObject, number?, number?) -> number,
	_findtextEx: (string, string | ByondObject, number?, number?) -> number,
	_lowertext: (string) -> string,
	_trimtext: (string) -> string,
	_replacetext: (string, string | ByondObject, string, number?, number?) -> number,
	_replacetextEx: (string, string | ByondObject, string, number?, number?) -> number,

	-- rng
	_pick_list: (ByondList) -> ByondValue,
	_prob: (number) -> BooleanLike,
	_rand: (number?, number?) -> number,
	_roll: (number) -> number,

	-- animation
	_animate: (ByondObject, NamedByondList, number?, boolean?, number?, number?) -> (),
	_flick: (string, ByondObject) -> (),

	-- traits
	_has_trait: (ByondObject, string) -> BooleanLike,
	_add_trait: (ByondObject, string, string?) -> (),
	_remove_trait: (ByondObject, string, string?) -> (),

	-- paths/types
	_text2path: (string) -> TypePath,
	_istype: (any, TypePath) -> BooleanLike,
	_ispath: (any, TypePath) -> BooleanLike,

	-- misc
	_hascall: (ByondObject, string) -> BooleanLike,
	_md5: (string) -> string,
	_length: (ByondValue) -> number,
	_params2list: (string) -> NamedTable<string>,
}

type GlobalProcs = {
	qdel: (ByondValueNoProc) -> (),

	-- ref stuff
	REF: (ByondObject) -> string,
	WEAKREF: (ByondObject) -> Weakref,

	-- assorted helpers
	trim: (string, number?) -> string,
	sanitize: (string) -> string,
	get_line: (ByondObject, ByondObject) -> ObjectArray,

	-- spatial info
	get_hearers_in_LOS: (number, ByondObject) -> ObjectArray,
	get_hearers_in_view: (number, ByondObject) -> ObjectArray,

	-- turf helpers
	get_atom_on_turf: (ByondObject, TypePath?) -> ByondObject,
	get_edge_target_turf: (ByondObject, number) -> ByondObject,
	get_ranged_target_turf: (ByondObject, number, number) -> ByondObject,
	get_offset_target_turf: (ByondObject, number, number) -> ByondObject,

	-- misc
	key_name: (ByondObject, boolean?, boolean?) -> string,
	key_name_admin: (ByondObject, boolean?) -> string,
} & SdqlWrappers & NamedTable<Proc>

declare list: {
	add: (ByondObject, any) -> (),
	remove: (ByondObject, any) -> (),
	to_table: (ByondObject) -> AnyTable,
	filter: (ByondObject, TypePath) -> ByondList
}

declare dm: {
	world: DmWorld,
	usr: ByondObject,
	new: (TypePath, ...ByondValue) -> ByondObject,
	is_valid_ref: (ByondObject) -> boolean,
	global_vars: GlobalVars,
	global_procs: GlobalProcs,
}

declare _exec: {
	time: number,
	limit: number,
	next_yield_index: number
}
