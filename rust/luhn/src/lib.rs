extern crate rustler;

use rustler::{Env, Term};

pub fn on_load(_env: Env, _load_info: Term) -> bool {
    true
}

#[rustler::nif]
pub fn add(left: usize, right: usize) -> usize {
    left + right
}

rustler::init!("luhn", [add], load = on_load);
