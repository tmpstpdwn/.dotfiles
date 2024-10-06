const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#070102", /* black   */
  [1] = "#2E0406", /* red     */
  [2] = "#4F080A", /* green   */
  [3] = "#6F0C0D", /* yellow  */
  [4] = "#392221", /* blue    */
  [5] = "#9F1813", /* magenta */
  [6] = "#6B2925", /* cyan    */
  [7] = "#D12E1A", /* white   */

  /* 8 bright colors */
  [8]  = "#724A41",  /* black   */
  [9]  = "#A85544",  /* red     */
  [10] = "#E45430", /* green   */
  [11] = "#E86F4B", /* yellow  */
  [12] = "#D87B82", /* blue    */
  [13] = "#F0945E", /* magenta */
  [14] = "#E5BC6E", /* cyan    */
  [15] = "#F5E0B0", /* white   */

  /* special colors */
  [256] = "#070102", /* background */
  [257] = "#D12E1A", /* foreground */
  [258] = "#724A41",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
