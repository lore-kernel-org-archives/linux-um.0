Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyJMH-0001K6-E2 for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 15:31:29 -0800
Received: from zcars04f.nortelnetworks.com ([47.129.242.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyJ9h-0003Ef-CY for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 15:18:29 -0800
Message-ID: <40451634.70902@nortelnetworks.com>
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
References: <4043B42A.10803@nortelnetworks.com>
	<200403020100.i2210dM9025649@ccure.user-mode-linux.org>
	<4044A368.8050406@nortelnetworks.com>
	<200403022054.i22KslWo003006@ccure.user-mode-linux.org>
	<40450A08.8090608@nortelnetworks.com>
	<200403022322.i22NM8Wo003853@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: problems with UML, issues with includes
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
Date: Tue, 02 Mar 2004 18:18:12 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>

Jeff Dike wrote:
> cfriesen@nortelnetworks.com said:
> 
>>#1  0xa00d03d6 in activate_fd (irq=3, fd=47, type=1,
>>dev_id=0xa02309f8) at irq_user.c:230 
>>
> 
> Why don't your line numbers match mine?  

I've added debug statements.

The kfree you seem to be talking
> about is this:

> 
>    211   out_unlock:
>    212          irq_unlock(flags);
>    213          kfree(new_fd);
>    214   out:
> 
> And I totally don't see a problem there.  new_fd isn't on any lists when it's
> freed there.

As mentioned in my other message, I'm seeing um_kmalloc() return a 
new_fd address that is *already* on the active_fds list.  Hence it ends 
up looking like a dupe, hence we end up calling kfree() on an address 
that is still on the active_fds list.

I made the following changes within activate_fd() to try and see what's 
going on.  If I set a breakpoint at the "redo=1" line and then step 
through the code, I end up in a continuous loop getting the same value 
for the return code of um_kmalloc().  There's something fishy going on 
here....

get_mem:
	new_fd = um_kmalloc(sizeof(*new_fd));	
	err = -ENOMEM;
	if(new_fd == NULL)
		goto out;
	
	redo = 0;
	flags = irq_lock();
	for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
		
		if (irq_fd == new_fd) {
			redo = 1;
		}
	}
	irq_unlock(flags);
	
	if (redo)
		goto get_mem;


Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
