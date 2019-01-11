import '../css/app.scss';
import 'phoenix_html';
import { Socket } from 'phoenix';

const socket = new Socket('/socket', {});
socket.connect();
const url = new URL(document.URL);
const channel_id =
  url.searchParams.get('id') || Math.floor(Math.random() * 100);

document.getElementById('channel-id').textContent = channel_id;
const link = `${url.origin}/?id=${channel_id}`;
const shareLink = document.getElementById('share-link');
shareLink.href = link;
shareLink.textContent = link;

const channel = socket.channel(`bingo:${channel_id}`);
channel.join().receive('ok', objectives => {
  for (let i = 0; i < objectives.length; i += 1) {
    document.querySelector(
      `.bingo__item[data-index="${i}"] > .bingo__item__text`
    ).textContent = objectives[i];
  }
});

function chooseItem() {
  channel.push('choose', { num: this.getAttribute('data-index'), player });
}
document
  .querySelectorAll('.bingo__item')
  .forEach(elem => elem.addEventListener('click', chooseItem));

channel.on('chosen', ({ num, player }) => {
  const elem = document.querySelectorAll(`.bingo__item`)[num];
  elem.classList.add(`bingo__item--selected-${player}`);
  elem.removeEventListener('click', chooseItem);
});

let player = 1;

document.querySelectorAll('input[name="player"]').forEach(elem => {
  elem.addEventListener('change', function(event) {
    player = parseInt(event.target.value, 10);
  });
});
