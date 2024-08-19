<?php

namespace App\Filament\Resources\PatientResource\Widgets;

use App\Models\Owner;
use App\Models\Patient;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class OwnerOverview extends BaseWidget
{
    protected function getStats(): array
    {
        $owners = Owner::all();
        $arr = [];
        foreach($owners as $owner){
            $arr[] = Stat::make($owner->name, Patient::query()->where('owner_id', $owner->id)->count());
        }
        return $arr;
    }
}
