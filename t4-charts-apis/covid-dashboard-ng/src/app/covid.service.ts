import { Injectable } from '@angular/core';
import {Observable} from "rxjs";
import {HttpClient} from "@angular/common/http";

const BASE_URL = 'https://api.covid19api.com';
const COUNTRY = 'singapore';
@Injectable({
  providedIn: 'root'
})
export class CovidService {

  constructor(private http: HttpClient) { }

  getCovidRecords(start: Date, end: Date): Observable<any> {
    const query_str = `${BASE_URL}/country/${COUNTRY}?from=${start.toISOString()}&to=${end.toISOString()}`;
    console.log("Query string: ", query_str);
    return this.http.get(query_str);
  }
}
