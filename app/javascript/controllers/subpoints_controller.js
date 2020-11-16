import { Controller } from "stimulus"
import { buildSubpointsChannel } from '../channels/subpoints_channel'

export default class extends Controller {
  connect () {
    console.log(this.data.get('channel'));
    buildSubpointsChannel(this.data.get('channel'));
  }
}
