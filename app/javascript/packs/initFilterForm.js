const initFilterForm = () => {
  const select = document.querySelectorAll('.filter-box label');

  const toggleActiveClass = (event) => {
    event.currentTarget.classList.toggle('active');
  };

  const toggleActiveOnClick = (select) => {
    select.addEventListener('click', toggleActiveClass);
  };

  select.forEach(toggleActiveOnClick);

}
 export { initFilterForm }
