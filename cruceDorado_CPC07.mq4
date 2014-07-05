//+------------------------------------------------------------------+
//|                                            cruceDorado_CPC07.mq4 |
//|        Copyright 2014, ARCHON Financial Management & Investments |
//|        https://github.com/gustavovasquezperdomo/RoboTrading      |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, ARCHON Financial Management & Investments"
#property link      ""
#property version   "1.00"
#property strict
//--- input parameters
input int      velasEMA1=14;
input int      velasEMA2=80;
input int      velasEMA3=200;
input int      stopLoss=500;
input int      takeProfit=1500;
input double   Lots=0.1;
double ema1, ema1ant, ema2, ema2ant;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   // Si queremos que el EA haga alguna función al empezar.
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   // Si queremos que el EA haga alguna función al terminar, como liberar memoria o cerrar las posiciones que continúen abiertas.
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   // Definición de Constantes y Variables
   string Simbolo = Symbol();
   int ticket;
   
   // Validación de la cantidad de Barras
   if(Bars<100)
     {
      Print("Hay menos de 100 barras");
      return(0);
     }
   if(takeProfit<10)
     {
      Print("El take Profit se ha establecido en menos de 10 Pips");
      return(0);  // Busca el TakeProfit
     }


  //ema1 es la ema corta cerca al precio  
   ema1 = iMA(Simbolo,0,velasEMA1,0,MODE_EMA,PRICE_CLOSE,1);
   ema1ant = iMA(Simbolo,0,velasEMA1,0,MODE_EMA,PRICE_CLOSE,2);
   //ema2 es la ema corta cerca al precio
   ema2 = iMA(Simbolo,0,velasEMA2,0,MODE_EMA,PRICE_CLOSE,1);
   ema2ant = iMA(Simbolo,0,velasEMA2,0,MODE_EMA,PRICE_CLOSE,1);

// Incluir aquí la ema3tendencia

// ****************************************************************************
//
//
//
// ****************************************************************************


// Si la ema1 (rápida) es mayor que la ema2 (larga) y la ema1anterior (corta anterior) es menor que la ema2anterior
// es decir, si la ema rápida corta a la lenta de abajo hacia arriba, esperamos un aumento de precio
 if (ema1 > ema2 && ema1ant < ema2ant) 
   {//condicion de compra.
   ticket= OrderSend (Simbolo,OP_BUY,Lots,Ask,3,Ask-stopLoss*Point,Ask+takeProfit*Point);
   //ticket=OrderSend(Symbol(),OP_SELL,Lots,Bid,3,0,Bid-TakeProfit*Point,"MACD + EMA 200",16384,0,Red);
   }

// Si la ema1 (rápida) es menor que la ema2 (larga) y la ema1anterior (corta anterior) es mayor que la ema2anterior
// es decir, si la ema rápida corta a la lenta de arriba hacia abajo, esperamos una disminución de precio

 if (ema1 < ema2 && ema1ant > ema2ant) 
   {//condicion de Venta.
   ticket = OrderSend (Simbolo,OP_SELL,Lots,Bid,3,Bid+stopLoss*Point,Bid-takeProfit*Point);
   }



  }
//+------------------------------------------------------------------+
