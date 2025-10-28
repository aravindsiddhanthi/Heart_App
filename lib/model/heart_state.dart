// the Model layer defines 4 heart states which uses mainly inside of the app
// viewmodel can uses this states to decide what type of UI,buttons to display.

enum HeartStatus {
  empty, //inital state where heart is not filled yet
  filling, // here it will fill actively
  filled, // 100% completed
  success, // enabled upon filled and navigates to success screen
}
