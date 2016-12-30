$('.page_events').ready(function(){
  new Vue({
    el: '#event-activity',
    data() {
      return {
        events: [],
        isLoading: false,
        isEnd: false
      }
    },
    computed: {
      groupedEvents(){
        return this.groupEvents()
      }
    },
    beforeCreate() {
      $.getJSON('/teams/1/events/data')
        .then(data => {
          this.events = data
        })
    },
    methods: {
      nextPage: function(){
        if (this.isEnd) return
        this.isLoading = true
        let events = this.events
        $.getJSON('/teams/1/events/data', { till_id: events[events.length - 1].id})
          .then(data => {
            this.events.push(...data)
            this.isLoading = false
            if (data.length === 0) this.isEnd = true
          })
      },
      unshiftEvent: function(data){
        this.events.unshift(data)
      },
      wheelEvent: function (event) {
        if (event.deltaY > 0 && this.$el.scrollTop >= this.$el.scrollHeight - this.$el.clientHeight && !this.isLoading)
          this.nextPage()
      },
      groupEvents: function(){
        return this.events.map(event => {
          let created_at = new Date(event.created_at)
          event.time = created_at.Format("hh:mm:ss")
          event.date = created_at.Format("yyyy-MM-dd")
          return event
        })
      }
    }
  })
})
