import { Component } from '@angular/core';
import { Column } from '@antv/g2plot';
import {CovidService} from "./covid.service";
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.less']
})
export class AppComponent {
  title = 'covid-dashboard-ng';

  data = [];

  constructor(private covidService: CovidService) {
  }

  ngOnInit() {
    const start = new Date(2022,1,1,);
    start.setHours(0, 0, 0, 0);
    const end = new Date();
    end.setHours(0, 0, 0, 0);
    this.covidService.getCovidRecords(start, end).subscribe(
      (data) => {
        this.data = data;
        this.data.forEach(
          (d: any) => d.Date = d.Date.split('T')[0]
        );
        console.log(this.data);
        const columnPlot = new Column('container',  {
          data: this.data,
          xField: 'Date',
          yField: 'Confirmed',
        });

        columnPlot.render();
      }
    );


    // Called after the constructor and called  after the first ngOnChanges()
  }
}
