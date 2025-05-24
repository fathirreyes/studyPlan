<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;
use Carbon\Carbon;

class TaskController extends Controller
{
    public function index()
    {
        return response()->json(Task::all());
    }

    public function store(Request $request)
    {
        $task = Task::create($request->all());
        return response()->json($task, 201);
    }

    public function today()
    {
        $today = Carbon::today()->toDateString();
        $tasks = Task::whereDate('current_time', $today)->get();
        return response()->json($tasks);
    }
}
