const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#1B2627", /* black   */
  [1] = "#282828", /* red     */
  [2] = "#5D2D2D", /* green   */
  [3] = "#48403F", /* yellow  */
  [4] = "#9D2B2C", /* blue    */
  [5] = "#3C4847", /* magenta */
  [6] = "#4E625A", /* cyan    */
  [7] = "#B44740", /* white   */

  /* 8 bright colors */
  [8]  = "#D24637",  /* black   */
  [9]  = "#506C5C",  /* red     */
  [10] = "#F14E39", /* green   */
  [11] = "#F05846", /* yellow  */
  [12] = "#DF675E", /* blue    */
  [13] = "#A68775", /* magenta */
  [14] = "#D89D92", /* cyan    */
  [15] = "#D7C59F", /* white   */

  /* special colors */
  [256] = "#1B2627", /* background */
  [257] = "#B44740", /* foreground */
  [258] = "#D24637",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
