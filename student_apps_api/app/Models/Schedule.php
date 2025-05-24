<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Schedule extends Model
{
    protected $fillable = [
        'day',
        'subject',
        'teacher',
        'room',
        'start_time',
        'end_time',
    ];
}
