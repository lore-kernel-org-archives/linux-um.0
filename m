Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/5] um: port: Delete three error messages for a failed
 memory allocation
References: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
 <651ecf90-9c68-aec1-58d7-d11e7671ed4c@users.sourceforge.net>
 <20170119000748.GB12052@parts.user-mode-linux.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <11675f60-3f56-d3a7-e8f8-1544c7a8567d@users.sourceforge.net>
Date: Thu, 19 Jan 2017 10:38:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170119000748.GB12052@parts.user-mode-linux.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net, Anton Ivanov <aivanov@kot-begemot.co.uk>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>, Richard Weinberger <richard@nod.at>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

>> +++ b/arch/um/drivers/port_kern.c
>> @@ -87,11 +87,8 @@ static int port_accept(struct port_list *port)
>>  	}
>>  
>>  	conn = kmalloc(sizeof(*conn), GFP_ATOMIC);
>> -	if (conn == NULL) {
>> -		printk(KERN_ERR "port_accept : failed to allocate "
>> -		       "connection\n");
>> +	if (!conn)
>>  		goto out_close;
>> -	}
>>  	*conn = ((struct connection)
>>  		{ .list 	= LIST_HEAD_INIT(conn->list),
>>  		  .fd 		= fd,
> 
> I don't see how this eliminates a possible error.

The suggested change affects three coding style issues at this place.

* Repetition of an out-of-memory message

  See also:
  http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf

* Unwanted splitting of a message string

* Usage of a specific preprocessor symbol


> !x is something you use with something that is conceptually a Boolean.

Pointers can be also treated in this way, can't they?

Regards,
Markus

