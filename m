Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8iJu-0007kO-13 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 09:16:34 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D8iJm-0002GR-Ch
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 09:16:33 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] how to "freeze" user mode linux
References: <OF047F9E8E.223EEE65-ON48256FBE.0027DB68-48256FBE.002A9758@cosmobic.com>
In-Reply-To: <OF047F9E8E.223EEE65-ON48256FBE.0027DB68-48256FBE.002A9758@cosmobic.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503081113.32380.rob@landley.net>
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
Date: Tue, 8 Mar 2005 11:13:32 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: siegfried@cosmobic.com

On Tuesday 08 March 2005 02:45 am, siegfried@cosmobic.com wrote:
> hello everyone:
>
> I am a new coder of embed linux app development .I use "User Mode Linux "
> as host stimulator environment where our applications running  .now I have
> a big problem !
> I debug my code which are some processes/threads living in UML with gdb .
> First, I make a break point on a process living in UML .Once I touch the
> break point (this process/thread will be suspended)---BUT,other
> process/thread are still in normal status .Soon ,these process/threads will
> be suspended one after another because they are  waiting the feedback come
> from the process/thread which are bing debugged .Unfortunately,when I
> continue the process/threads, the process/thread can't return to the
> orginial status because other processes /threads are in error status (time
> out etc.)
> How to "freeze" the whole "user mode linux" --all processes/threads in
> "UML"and "UML" kernel even "UML" system timer!!!
> and, how to recover it???

Does swsusp work under UML? :)

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
