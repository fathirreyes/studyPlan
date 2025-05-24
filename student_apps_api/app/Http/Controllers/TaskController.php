<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function index()
    {
        return response()->json(Task::all());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'date' => 'required|date',
        ]);

        return Task::create($validated);
    }


    public function update(Request $request, $id)
    {
        $task = Task::findOrFail($id);

        $validated = $request->validate([
            'subject' => 'required|string|max:255',
            'teacher' => 'required|string|max:255',
            'start_time' => 'required',
            'end_time' => 'required',
            'day' => 'required|string',
            'room' => 'required|string|max:255', // ✅ ini yang tadi kelewat
        ]);

        $task->update($validated);

        return response()->json(['message' => 'Jadwal berhasil diperbarui']);
        // $task = Task::findOrFail($id);
        // $task->update($request->only('title', 'description'));
        // return response()->json($task);
    }

    public function destroy($id)
    {
        $task = Task::findOrFail($id);
        $task->delete();
        return response()->json(['message' => 'Tugas berhasil dihapus']);
    }

    public function markDone($id)
    {
        $task = Task::findOrFail($id);
        $task->is_done = true;
        $task->save();
        return response()->json($task);
    }
}
// use App\Models\Task;
// use Illuminate\Http\Request;
// use Carbon\Carbon;

// class TaskController extends Controller
// {
//     public function index()
//     {
//         return response()->json(Task::all());
//     }

//     public function store(Request $request)
//     {
//         $task = Task::create($request->all());
//         return response()->json($task, 201);
//     }

//     public function today()
//     {
//         $today = Carbon::today()->toDateString();
//         $tasks = Task::whereDate('current_time', $today)->get();
//         return response()->json($tasks);
//     }
// }
