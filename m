Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEuGZ-0008Dw-Kr for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 11:42:27 -0700
Received: from bay22-f9.bay22.hotmail.com ([64.4.16.59] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEuGN-0002C9-47 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 11:42:27 -0700
From: "Young K" <young_uml@hotmail.com>
Subject: Re: [uml-devel] slow execution in uml?
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY22-F95cizlK4nNAR00009729@hotmail.com>
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
Date: Tue, 05 Oct 2004 14:41:34 -0400
To: blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

Hi,

>
>What is slower in UML (a lot slower) is (at least):
>- syscall execution
>- page fault
>
>At a first glance, I wouldn't be surprised if the syscall itself took 
>26,000
>cycles (they are rdtsc units, right?).

Thanks for the reply. But, i measured the time after sys_sendto() is called. 
i mean, timestamp was made inside sys_sendto() kernel routine. so, syscall 
overhead wouldn't be included. what do you think?

_________________________________________________________________
Check out Election 2004 for up-to-date election news, plus voter tools and 
more! http://special.msn.com/msn/election2004.armx



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
