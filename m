Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyZmG-0003pU-0Z for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 09:03:24 -0800
Received: from zcars04f.nortelnetworks.com ([47.129.242.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AyZGH-00038W-K7 for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 08:30:21 -0800
Message-ID: <40460CA2.2000000@nortelnetworks.com>
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
References: <4043B42A.10803@nortelnetworks.com>
	<200403020100.i2210dM9025649@ccure.user-mode-linux.org>
	<4044A368.8050406@nortelnetworks.com>
	<200403022054.i22KslWo003006@ccure.user-mode-linux.org>
	<40450A08.8090608@nortelnetworks.com>
	<200403022322.i22NM8Wo003853@ccure.user-mode-linux.org>
	<40451AAB.5050304@nortelnetworks.com>
	<200403030133.i231XJWo004412@ccure.user-mode-linux.org>
In-Reply-To: <200403030133.i231XJWo004412@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: problems with UML -- new data with memory debugging on
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
Date: Wed, 03 Mar 2004 11:49:38 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>

Jeff Dike wrote:
> cfriesen@nortelnetworks.com said:
> 
>>I turned on memory debugging, and got the following.  Line 1439 in
>>slab.c is 
> 
> 
> Excellent.  Can you add the following to hostfs_read_super (not a real patch -
> add that line by hand)?
> 
>  out_dput:
> 	dput(sb->s_root);
> +	return(NULL);
>  out_free:
> 	kfree(root_dir);
> 
> The dput is doing some cleanup for me that I wasn't aware of, including freeing
> stuff.

Looks like that cleaned it up for the minimal setup that was triggering 
the fault.

I'll test it with the full configuration and see how that goes...

Thanks,

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
