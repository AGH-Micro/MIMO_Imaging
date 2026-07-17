Instrukcja do kodu do samplowania

PINOUT
Q+ - PA6
Q- - PA7

I+ - PF11
I- - PF12


Rozmiar bufora można zmieniać definem BUFFER_SIZE. Uwaga - to całkowity rozmiar bufora obsługujący 2 kanały ADC.
ADC działa w trybie CIRCULAR czyli pobiera na zmianę próbkę z jednego i drugiego kanału i wpisuje do tego samego bufora.

Częstotliwość próbkowania można zmieniać dzielnikiem zegara:
	hadc1.Init.ClockPrescaler = ADC_CLOCK_ASYNC_DIV*

Wyliczyć ją można:
	1.5 MHz(Częstotliwość zegara ADC)
	/4 (ADC_CLOCK_ASYNC_DIV) 
	/10 (tyle cykli zegara SAR potrzebuje na konwersje) 
	/ 2 (bo 2 kanały ADC)
	/ 2 (nie wiem czemu, podczas testów tak wychodzi że trzeba to jeszcze na 2 podzielić żeby wyszło poprawnie, może chodzi o to że kanały ADC działają różnicowo)

WAŻNE!
Kod jest podzielony na bloki zaznaczone komentarzami np.

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

Są one wygenerowane przez konfigurator więc to ważne żeby kod dopisywać właśnie w tych segmentach, w przeciwnym wypadku podczas zmiany konfiuguracji dopisany kod może zostać usunięty.


