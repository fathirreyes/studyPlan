<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tasks', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description');
            $table->boolean('is_done')->default(false);
            $table->date('due_date')->nullable();
            $table->timestamps();
        });
        // Schema::create('tasks', function (Blueprint $table) {
        //     $table->id();
        //     $table->string('title');
        //     $table->string('subtitle');
        //     $table->string('name');
        //     $table->string('room');
        //     $table->string('current_time');
        //     $table->string('remaining_time');
        //     $table->timestamps();
        // });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tasks');
    }
};
