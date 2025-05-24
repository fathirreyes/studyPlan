<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    use HasFactory;
    protected $fillable = [
        'title',
        'subtitle',
        'name',
        'room',
        'current_time',
        'remaining_time',
    ];

    public function toArray()
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'subtitle' => $this->subtitle,
            'name' => $this->name,
            'room' => $this->room,
            'current_time' => $this->current_time,
            'remaining_time' => $this->remaining_time, // pakai kurung kurawal karena ada spasi
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
