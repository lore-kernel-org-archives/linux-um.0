Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxVue-0004Gz-Ns for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 12:15:56 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BxVue-0006TQ-0V for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 12:15:56 -0700
Message-ID: <4123AAFA.4020502@exse.net>
From: seb <seb@exse.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] debug 2.6.7
References: <41234F99.6020208@exse.net>
	<Pine.LNX.4.58.0408181036130.14238@gradall.private.brainfood.com>
In-Reply-To: <Pine.LNX.4.58.0408181036130.14238@gradall.private.brainfood.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 18 Aug 2004 21:16:10 +0200
To: Adam Heath <adam@doogie.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi Adam,

I let the memory consumtion of "xmlhandler.fcpl" grew with intend to see 
what will happen.

The result was a kernel panic (which should not happen).

For a reason unknown to me, I was not able the get the backtrace for 
that panic, do you know how to do ? (see my first mail)


PS: currently I am testing user-mode-linux for a large scale deployment 
in my company, but Iam faced with a number of unresolved problems. (for 
sure, most of them due to my lack of understanding how to do it right, 
but not all). My C coding skills are not good enough to fix the bugs, 
the only thing I can to is to stress uml and make bugs reproducable, to 
help the core delopers to fix them.

/sebastian

Adam Heath wrote:

>On Wed, 18 Aug 2004, seb wrote:
>
>  
>
>>Hi,
>>
>>---------------------------
>>Starting MTA: exim4.
>>Starting PostgreSQL database server: postmaster.
>>Starting OpenBSD Secure Shell server: sshd.
>>Starting deferred execution scheduler: atd.
>>Starting periodic command scheduler: cron.
>>
>>Debian GNU/Linux 3.1 vhost tty0
>>
>>vhost login: Out of Memory: Killed process 3773 (xmlhandler.fcpl).
>>    
>>
>
>Increase the memory for the uml, using 'mem=xxx' on the cmdline.  The default
>is 32m.
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
>100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
>Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
>http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
>_______________________________________________
>User-mode-linux-devel mailing list
>User-mode-linux-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>  
>



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
