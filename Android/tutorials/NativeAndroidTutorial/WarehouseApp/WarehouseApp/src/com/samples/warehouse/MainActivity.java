/*
 * Copyright (c) 2013, salesforce.com, inc.
 * All rights reserved.
 * Redistribution and use of this software in source and binary forms, with or
 * without modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * - Neither the name of salesforce.com, inc. nor the names of its contributors
 * may be used to endorse or promote products derived from this software without
 * specific prior written permission of salesforce.com, inc.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
package com.samples.warehouse;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.salesforce.androidsdk.app.SalesforceSDKManager;
import com.salesforce.androidsdk.rest.RestClient;
import com.salesforce.androidsdk.rest.RestClient.AsyncRequestCallback;
import com.salesforce.androidsdk.rest.RestRequest;
import com.salesforce.androidsdk.rest.RestResponse;
import com.salesforce.androidsdk.ui.sfnative.SalesforceActivity;

/**
 * Main activity
 */
public class MainActivity extends SalesforceActivity implements OnItemClickListener {

    private RestClient client;
    private ArrayAdapter<Merchandise> listAdapter;
    private ListView listView;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		// Setup view
		setContentView(R.layout.main);
	}
	
	@Override 
	public void onResume() {
		// Hide everything until we are logged in
		findViewById(R.id.root).setVisibility(View.INVISIBLE);

		// Get handle for list view
		listView = (ListView) findViewById(R.id.contacts_list);

		// Setup list adapter
		listAdapter = new ArrayAdapter<Merchandise>(this, android.R.layout.simple_list_item_1, new ArrayList<Merchandise>());
		listView.setAdapter(listAdapter);
		
		// Setup list item click listener
		listView.setOnItemClickListener(this);
		
		super.onResume();
	}		
	
	@Override
	public void onResume(RestClient client) {
        // Keeping reference to rest client
        this.client = client; 

		// Show everything
		findViewById(R.id.root).setVisibility(View.VISIBLE);
		
		// Fetch data for list
		fetchDataForList();
	}

	/**
	 * Called when "Logout" button is clicked. 
	 * 
	 * @param v
	 */
	public void onLogoutClick(View v) {
		SalesforceSDKManager.getInstance().logout(this);
	}
	
	/**
	 * Called when list item is clicked
	 * @param parent
	 * @param view
	 * @param position
	 * @param id
	 */
	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
		Merchandise merchandise = listAdapter.getItem(position);
        Intent intent = new Intent(this, DetailActivity.class);
        intent.putExtra("id", merchandise.id);
        intent.putExtra("name", merchandise.name);
        intent.putExtra("quantity", merchandise.quantity);
        intent.putExtra("price", merchandise.price);
        startActivity(intent);
	}
	

	/**
	 * Helper method to fetch data from server and update list 
	 * @param soql
	 */
	private void fetchDataForList()  {
		String soql = "SELECT Name, Id, Price__c, Quantity__c FROM Merchandise__c LIMIT 10";
		
		RestRequest restRequest = null;
		try {
			restRequest = RestRequest.getRequestForQuery(getString(R.string.api_version), soql);
		} catch (UnsupportedEncodingException e) {
			showError(MainActivity.this, e);
			return;
		}

		client.sendAsync(restRequest, new AsyncRequestCallback() {
			@Override
			public void onSuccess(RestRequest request, RestResponse result) {
				try {
					listAdapter.clear();
					JSONArray records = result.asJSONObject().getJSONArray("records");
					for (int i = 0; i < records.length(); i++) {
						JSONObject record = records.getJSONObject(i);
						Merchandise merchandise = new Merchandise(record.getString("Name"), record.getString("Id"), record.getInt("Quantity__c"), record.getDouble("Price__c"));
						listAdapter.add(merchandise);
					}					
				} catch (Exception e) {
					showError(MainActivity.this, e);
				}
			}
			
			@Override
			public void onError(Exception e) {
				showError(MainActivity.this, e);
			}
		});
	}
	
	/**
	 * Helper method to show an error with a toast
	 * @param e
	 */
	public static void showError(Context context, Exception e) {
        Toast toast = Toast.makeText(context, context.getString(SalesforceSDKManager.getInstance().getSalesforceR().stringGenericError(), e.toString()),
	        	   Toast.LENGTH_LONG);
		toast.show();
	}
	
	/**
	 * Simple class to represent a Merchandise
	 */
	static class Merchandise {
		public final String name;
		public final String id;
		public final int quantity;
		public final double price;
		
		public Merchandise(String name, String id, int quantity, double price) {
			this.name = name;
			this.id = id;
			this.quantity = quantity;
			this.price = price;
		}
		
		public String toString() {
			return name;
		}
	}
	
}
