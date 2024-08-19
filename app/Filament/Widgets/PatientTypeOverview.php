<?php

namespace App\Filament\Widgets;

use App\Models\Patient;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class PatientTypeOverview extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make('皮膚', Patient::query()->where('type', '皮膚')->count()),
            Stat::make('視覚', Patient::query()->where('type', '視覚')->count()),
            Stat::make('Fever', Patient::query()->where('type', 'fever')->count()),
        ];
    }
}
