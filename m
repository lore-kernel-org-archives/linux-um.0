Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Auzew-0003r2-Ea for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 11:53:02 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AuzXh-0007Fk-AO for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 11:45:33 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] patch: use elv_queue_empty
References: <20040208181109.G1325@almesberger.net>
In-Reply-To: <20040208181109.G1325@almesberger.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402221933.32232.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 22 Feb 2004 19:33:32 +0100
To: Werner Almesberger <werner@almesberger.net>, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 22:11, domenica 8 febbraio 2004, Werner Almesberger ha scritto:
> This patch makes UBD a little more compatible with alternative
> elevators that may not use a single request queue.

> --- linux-2.6.1/arch/um/drivers/ubd_kern.c.orig	Sun Feb  8 17:16:51 2004
> +++ linux-2.6.1/arch/um/drivers/ubd_kern.c	Sun Feb  8 17:17:32 2004
> @@ -1034,7 +1034,7 @@
>  	int err, n;
>
>  	if(thread_fd == -1){
> -		while(!list_empty(&q->queue_head)){
> +		while(!elv_queue_empty(q)){
>  			req = elv_next_request(q);
>  			err = prepare_request(req, &io_req);
>  			if(!err){
> @@ -1044,7 +1044,7 @@
>  		}
>  	}
>  	else {
> -		if(do_ubd || list_empty(&q->queue_head)) return;
> +		if(do_ubd || elv_queue_empty(q)) return;
>  		req = elv_next_request(q);
>  		err = prepare_request(req, &io_req);
>  		if(!err){

The old code was basically wrong - but Documentation/block/biodoc.txt 
recommends using just elv_next_request - i.e. instead of looping until 
elv_queue_empty(q) is true, just loop until elv_next_request returns NULL.
Calling elv_queue_empty is meaningless to just check if queues are empty if we 
must not get a request right now, since that can save us the cost of 
dispatching pending requests. But this is not the case. So the code could 
become:

while (1) {
  req = elv_next_request(q);
  if (!req) break;
...}

and 

if(do_ubd) return;
req = elv_next_request(q);
if (!req) return;

Any idea against / in favour of this?
Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
