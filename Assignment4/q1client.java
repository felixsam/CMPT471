//Felix Sam
//q1client.java

import java.io.*;
import java.net.*;
import java.util.*;


public class q1client{
	//The ip address of the host: April
	//String ip_addr = "172.16.1.4";
	String ip_addr = "127.0.0.1";
	//Run on port 9999
	int port = 9999;
	//The socket for the client
	Socket client;
	//For reading the input from the user console
	BufferedReader input_from_console;
	//For reading the input from the server socket
	BufferedReader input_from_server;
	//For writing and sending messages to the server
	PrintWriter output_to_server;

	//For the Diffie-Hellman algorithm
	int prime = 23;
	int base = 5;
	int a = 10;
	//A = base^a mod prime
	int A;
	//B = base^b mod prime
	int B;
	// The shared secret key between client and server
	int shared_secret;

	//40 Characters including the 26 letters, numbers 0 - 9, symbol for space , comma period and question mark
	char[] characters = "abcdefghijklmnopqrstuvwxyz0123456789 ,.?".toCharArray();

	//The permutated characters array for substitution encryption scheme
	char[] sub_characters1 = "vmlcbgkyqusopaxejtwfrnhdzi6,03124?5978. ".toCharArray();

	//The second permutated characters array for substitution encryption scheme
	char[] sub_characters2 = "abc6543210zyxwvutsrqponmlkjihgfed789,.? ".toCharArray();

	//The third permutated characters array for substitution encryption scheme
	char[] sub_characters3 = "mogp658zdi0k3clqxrs27j4hbe9taunywfv1,.? ".toCharArray();

	//The fourth permutated characters array for substitution encryption scheme
	char[] sub_characters4 = "snithfvpz,da?bwkycor.mgjexulq8362041975 ".toCharArray();

	//The fifth permutated characters array for substitution encryption scheme
	char[] sub_characters5 = "ibhowmepnsdqzarjxfgcvtuykl7295014836?., ".toCharArray();

	/************************************************************************/
	/***************************** MAIN Program *****************************/
	/************************************************************************/
	public static void main(String args[]){
		//Create a new instance of the client class
		q1client client = new q1client();
		//Setup TCP Client
		client.setup();
		//Run Encryption Scheme
		client.execute();
	}

	//Setups TCP Server to accept messages from client and encrypt and decrypt messages
	public void setup(){


		try{
			System.out.println("Starting TCP Client for IP address: " + ip_addr + " on Port: " + String.valueOf(port));
			//Setup Client Server
			client = new Socket(ip_addr,port);
			//To send messages to server
			output_to_server = new PrintWriter(client.getOutputStream());
			//Reading input from console
			input_from_console = new BufferedReader(new InputStreamReader(System.in));
			//Reading input from server
			input_from_server = new BufferedReader(new InputStreamReader(client.getInputStream()));

		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void execute(){
		diffiehellman();

		//To hold the client message
		String message = "";
		String server_response;
		String encrypted_message = "";
		String decrypted_message = "";

		try{
			while(true){
				System.out.printf("Type a message to encrypt and send to the server: ");
				//Retrieve message from typed input
				message = input_from_console.readLine();
				//All messages will be processed as lowercase
				message = message.toLowerCase();
				System.out.println("Unencrypted message: " + message);
				//First encrypt using substitution scheme
				encrypted_message = sub_encrypt(message,shared_secret);
				//Then encrypt using transposition scheme
				encrypted_message = encrypt(encrypted_message,shared_secret);
				System.out.println("Encrypted Message to be sent to Server: " + encrypted_message);
				System.out.println("");
				//Send encrypted message to server
				output_to_server.println(encrypted_message);
				output_to_server.flush();

				//Get the response from the server
				server_response = input_from_server.readLine();
				System.out.println("Server's ACK response: " + server_response);
				//First decrypt using transposition scheme
				decrypted_message = decrypt(server_response,shared_secret);
				//Then decrypt using substitution scheme 
				decrypted_message = sub_decrypt(decrypted_message,shared_secret);
				System.out.println("Server's decrypted ACK: "+ decrypted_message);
				System.out.println("");
			}		
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	/************************************************************************/
	/************************ DIFFIE-HELLMAN ALGORITHM **********************/
	/************************************************************************/
	public void diffiehellman(){
		System.out.println("Begin DiffieHellman Key Exchange ");
		//A = b^a mod p
		A = (base^a) % prime;
		try{
			//Send computed A = base^a mod p to server 
			output_to_server.println("Diffie-Hellman Key Exchange:" + A);
			output_to_server.flush();

			//System.out.println("Waiting for Response from server");
			//Get response from server 
			String response = input_from_server.readLine();
			//System.out.println(response);
			//Split the response at : 
			//Part of the response will contain the calculated B
			String[] response_splitted = response.split(":");
			//Get B = base^b mod p to be used to calculate the shared_secret
			B = Integer.parseInt(response_splitted[1]);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		// secret key s = B^a mod p 
		shared_secret = (B^a) % prime;
		System.out.println("Shared Secret Value: " + shared_secret);
		System.out.println("");
	}

	/************************************************************************/
	/**************** HELPER FUNCTION FOR ENCRYPTION/DECRYPTION *************/
	/************************************************************************/
	public char[][] message_as_matrix(String message, int row, int column){
		char[][] array = new char[row][column];
		//counter to count position at message array
	    int counter = 0;
	    
	    //Initial Matrix
	    for (int i = 0; i< row; i++){
	        for (int j = 0; j<column; j++){
	            if (counter < message.length()){
                    char c = (char)(message.charAt(counter));
                    counter++;
                    array[i][j] = c;
	            }
	            else{
	                //Filler character when array is not square
	                array[i][j] = '#';
	            }
	        }
	    }
	    return array;
	}


	public char[][] transpose(char[][] matrix,int row, int column){
		char[][] transposed = new char[column][row];
		for (int i = 0; i<column; i++){
	        for (int j = 0; j<row; j++){
	            transposed[i][j] = matrix[j][i];	            
	        }
	    }
	    return transposed;
	}

	public String transpose_message(char[][] array, int row, int column){
		String message = "";
		for (int i = 0;i < column; i++){
			for (int j = 0; j< row; j++){
				message += array[i][j];
			}
		}
		return message;
	}

	public String detranspose_message(char[][] array, int row, int column){
		String message = "";
		for (int i = 0;i < column; i++){
			for (int j = 0; j< row; j++){
				//Check for filler char
				if (array[i][j] != '#'){
					message += array[i][j];
				}
			}
		}
		return message;
	}

	//Calculate the number of rows needed for the matrix given a number of columns
	public int get_rows(String message,int column){
		int row = 0;
		if (message.length() % column == 0){
			// If columns divide the message length evenly
			// then number of row = message length/number of column
	        row = message.length()/column;
	    }
	    else{
	    	//Message doesn't evenly divide
	    	//Add one to the number of rows calculated to fit in all characters of message
	        row = message.length()/column + 1;
	    }
	    return row;
	}

	//Calculate the number of columns needed for the matrix given a number of rows
	public int get_columns(String message,int row){
		int column = 0;
		if (message.length() % row == 0){
			// If rows divide the message length evenly
			// then number of columns = message length/number of rows
	        column = message.length()/row;
	    }
	    else{
	    	//Message doesn't evenly divide
	    	//Add one to the number of columns calculated to fit in all characters of message
	        column = message.length()/row + 1;
	    }
	    return column;
	}

	/************************************************************************/
	/**************************** ENCRYPTION METHOD *************************/
	/************************************************************************/

	public String encrypt(String message, int key){
	    
	    //Initial encrypted messsage is empty
	    String encrypted = "";
	    
	    //Test with number of columns = 4 for transpose array
	    int column = 4;

	    // Get number of rows to initialize matrix
	    int row = get_rows(message,column);
	    
	    //Create the initial matrix
	    char[][] array = message_as_matrix(message,row,column);

	    //Transpose the matrix
	    char[][] transposed = transpose(array,row,column);

	    encrypted = transpose_message(transposed,row,column);

	    //return the encrypted message
	    return encrypted;
	}

	public String sub_encrypt(String message, int key){
		//Initial encrypted messsage is empty
	    String encrypted = "";
	    char c;
	    char index;

	    //For each character of the original message
	    for (int i=0;i<message.length();i++){
	    	//Iterate through the characters array
	    	for (int j=0; j< characters.length;j++){
	    		//Get each character of original message
	    		c = (char)(message.charAt(i));
	    		//Get index of characters array
	    		index = characters[j];
	    		//If current character of original message matches index of characters array
	    		if (c == index){
	    			//Get the substitioned character in sub_character array of index
	    			//switch to one of the 5 substitution schemes based on shared secret key
	    			switch (key){
	    				case 1: encrypted += sub_characters5[j];
	    				case 2: encrypted += sub_characters4[j];
	    				case 3: encrypted += sub_characters3[j];
	    				case 4: encrypted += sub_characters2[j];
	    				default: encrypted += sub_characters1[j];
	    			}
	    			
	    		}
	    	}
	    }
	    return encrypted;
	}


	/************************************************************************/
	/*************************** DECRYPTION METHOD **************************/
	/************************************************************************/
	public String decrypt(String message, int key){	    
	    String decrypted = "";
	    
	    //Convert transposed matrix back to original matrix
	    //transposed matrix has row as column
	    //and column as row
	    
	    //There were 4 columns in original matrix that are now the number of rows in the transposed matrix
	    int row = 4;
	    //caclulate the number of columns for transpose array
	    int column = get_columns(message,row);
	    
	    //Create the transpose matrix
	    char[][] array = message_as_matrix(message,row,column);
	    	    
	    //Transpose the matrix to get back the original matrix
	    char[][] transposed = transpose(array,row,column);
	    
	    //Read out the matrix sequentially to get back the original message
	    decrypted = detranspose_message(transposed,row,column);

	    //return the decrypted message
	  	return decrypted;
	}

	public String sub_decrypt(String message, int key){
		//Initial encrypted messsage is empty
	    String decrypted = "";
	    char c;
	    char index;

	    //For each character in original message 
	    for (int i=0;i<message.length();i++){
	    	for (int j=0; j< characters.length;j++){
	    		//Get current character in original message
	    		c = (char)(message.charAt(i));
	    		//Get index of sub characters array 
	    		//Use that index to get the substituted character in original character array
	    		//switch to one of the 5 substitution schemes based on shared secret key
	    		switch(key){
	    			case 1: index = sub_characters5[j];
	    			case 2: index = sub_characters4[j];
	    			case 3: index = sub_characters3[j];
	    			case 4: index = sub_characters2[j];
	    			default: index = sub_characters1[j];
	    		}
	    		
	    		if (c == index){
	    			//Get the substitioned character in original character array of index
	    			decrypted += characters[j];
	    		}
	    	}
	    }
	    return decrypted;
	}
}