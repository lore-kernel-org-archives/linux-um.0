Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4qLB-0003Sw-3M for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 17:29:37 -0700
Received: from mail.britsys.net ([216.183.103.29] helo=mail02.WWW.BRITSYS.NET)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4qLA-0000Jn-MO for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 17:29:37 -0700
Message-ID: <413E5265.2080001@britsys.net>
From: David Jeffery <djeffery@britsys.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
References: <BACKUPJQjdF8qoH28Db000022d5@NOSPAM.BRITSYS.NET>
In-Reply-To: <BACKUPJQjdF8qoH28Db000022d5@NOSPAM.BRITSYS.NET>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 07 Sep 2004 20:29:25 -0400
To: ralston@stral.net
Cc: user-mode-linux-devel@lists.sourceforge.net, 'BlaisorBlade' <blaisorblade_spam@yahoo.it>

Michael Ralston wrote:

>I've been testing out this patch...
>
>It seems it allows me to start a uml-2.6.8.1 with SKAS using libc6-2.3.2.
>I'm not sure if programs that make use of NPTL are running correctly though.
>  
>

It depends on what part of pthreads the programs use.  My patch only 
fixes basic thread creation.  If you run the pthread test suite from 
LSB, you'll find there is alot still broken.  Sorry for my patch 
sounding more impressive than it was.  The few pthread things I ran work 
but they didn't make extensive use of the nptl's pthread features.  I'm 
going to try and look at what's broken but no guarantees I'll know how 
to fix it.

David Jeffery


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
