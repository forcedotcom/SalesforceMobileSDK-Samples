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

import java.util.HashMap;
import java.util.Map;

import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

import com.salesforce.androidsdk.app.SalesforceSDKManager;
import com.salesforce.androidsdk.rest.RestClient;
import com.salesforce.androidsdk.rest.RestClient.AsyncRequestCallback;
import com.salesforce.androidsdk.rest.RestRequest;
import com.salesforce.androidsdk.rest.RestResponse;
import com.salesforce.androidsdk.ui.sfnative.SalesforceActivity;

/**
 * Detail activity
 */
public class DetailActivity extends SalesforceActivity {

	private String merchandiseId;
	private RestClient client;
	private EditText nameField;
	private EditText priceField;
	private EditText quantityField;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		// Setup view
		setContentView(R.layout.detail);
		nameField = (EditText) findViewById(R.id.name_field);
		priceField = (EditText) findViewById(R.id.price_field);
		quantityField = (EditText) findViewById(R.id.quantity_field);

		// Populate fields with data from intent
		Bundle extras = getIntent().getExtras();
		merchandiseId = extras.getString("id");
		nameField.setText(extras.getString("name"));
		priceField.setText(extras.getDouble("price") + "");
		quantityField.setText(extras.getInt("quantity") + "");
	}
	
	@Override
	public void onResume(RestClient client) {
        // Keeping reference to rest client
        this.client = client; 
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
	 * Called when "Update" button is clicked. 
	 * 
	 * @param v
	 */
	public void onUpdateClick(View v) {
		Map<String, Object> fields = new HashMap<String, Object>();
		fields.put("Name", nameField.getText().toString());
		fields.put("Quantity__c", quantityField.getText().toString());
		fields.put("Price__c", priceField.getText().toString());
		saveData(merchandiseId, fields);
	}
	
	/**
	 * Helper method to save details back to server
	 * @param id
	 * @param fields
	 */
	private void saveData(String id, Map<String, Object> fields)  {
		RestRequest restRequest;
		try {
			restRequest = RestRequest.getRequestForUpdate(getString(R.string.api_version), "Merchandise__c", id, fields);
		} catch (Exception e) {
			MainActivity.showError(this, e);
			return;
		}
		
		client.sendAsync(restRequest, new AsyncRequestCallback() {
			@Override
			public void onSuccess(RestRequest request, RestResponse result) {
				try {
					DetailActivity.this.finish();
				} catch (Exception e) {
					MainActivity.showError(DetailActivity.this, e);
				}
			}
			
			@Override
			public void onError(Exception e) {
				MainActivity.showError(DetailActivity.this, e);
			}
		});
	}	
	
}
