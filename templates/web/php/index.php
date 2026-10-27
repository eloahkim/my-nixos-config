<?php

declare(strict_types=1);

function greeting(string $name): string
{
    return sprintf('Olá, %s!', $name);
}

echo greeting('PHP');
