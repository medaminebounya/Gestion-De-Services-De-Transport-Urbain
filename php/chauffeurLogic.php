<?php
/**
 * Backend logic for Chauffeur Ranking System
 * Based on points intervals from project documentation
 */

function getChauffeurRank($points) {
    // [0 à 100[ -> Aucun grade
    if ($points < 100) {
        return [
            'level' => 'Aucun grade',
            'medal' => 'none',
            'color' => '#64748b', // Gray
            'next_level' => 100 - $points . " points restants pour Bronze"
        ];
    }
    // [100 à 200[ -> Bronze
    if ($points >= 100 && $points < 200) {
        return [
            'level' => 'Bronze',
            'medal' => 'bronze',
            'color' => '#cd7f32', // Bronze color
            'next_level' => 200 - $points . " points restants pour Silver"
        ];
    }
    // [200 à 500[ -> Silver
    if ($points >= 200 && $points < 500) {
        return [
            'level' => 'Silver',
            'medal' => 'silver',
            'color' => '#c0c0c0', // Silver color
            'next_level' => 500 - $points . " points restants pour Gold"
        ];
    }
    // 500 et plus -> Gold
    if ($points >= 500) {
        return [
            'level' => 'Gold',
            'medal' => 'gold',
            'color' => '#ffd700', // Gold color
            'next_level' => 'Niveau Maximum atteint !'
        ];
    }
}

/**
 * Logic to update points after a ride
 * +1 for positive feedback, -1 for negative
 */
function updatePoints($conn, $id_chauffeur, $is_positive) {
    $change = $is_positive ? 1 : -1;
    $sql = "UPDATE chauffeur SET points = points + $change WHERE id_user = $id_chauffeur";
    return mysqli_query($conn, $sql);
}
?>