<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use Illuminate\Http\Request;
use Carbon\Carbon;

class ScheduleController extends Controller
{
    public function index()
    {
        return response()->json(Schedule::all());
    }

    public function store(Request $request)
    {
        $schedule = Schedule::create($request->all());
        return response()->json($schedule, 201);
    }

    public function today()
    {
        $today = now()->format('l'); // akan hasilkan nama hari seperti "Friday"
        $schedules = Schedule::where('day', $today)->get();
        return response()->json($schedules);
    }

    public function update(Request $request, $id)
    {
        $schedule = Schedule::findOrFail($id);

        $validated = $request->validate([
            'subject' => 'required|string|max:255',
            'teacher' => 'required|string|max:255',
            'start_time' => 'required',
            'end_time' => 'required',
            'day' => 'required|string',
            'room' => 'required|string|max:255', // ✅ ini yang tadi kelewat
        ]);

        $schedule->update($validated);

        return response()->json(['message' => 'Jadwal berhasil diperbarui']);
    }
    public function destroy($id)
    {
        $schedule = Schedule::findOrFail($id);
        $schedule->delete();
        return response()->json(['message' => 'Jadwal berhasil dihapus']);
    }
}
