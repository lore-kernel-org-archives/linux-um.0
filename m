Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D96nd-0004fq-NA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:24:53 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D96nY-0005jM-VI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:24:53 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] how to "freeze" user mode linux
References: <OF047F9E8E.223EEE65-ON48256FBE.0027DB68-48256FBE.002A9758@cosmobic.com>
	<200503081113.32380.rob@landley.net>
In-Reply-To: <200503081113.32380.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503092024.27077.blaisorblade@yahoo.it>
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
Date: Wed, 9 Mar 2005 20:24:26 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, siegfried@cosmobic.com

On Tuesday 08 March 2005 17:13, Rob Landley wrote:
> On Tuesday 08 March 2005 02:45 am, siegfried@cosmobic.com wrote:
> > hello everyone:
> >
> > I am a new coder of embed linux app development .I use "User Mode Linux "
> > as host stimulator environment where our applications running  .now I
> > have a big problem !
> > I debug my code which are some processes/threads living in UML with gdb .
> > First, I make a break point on a process living in UML .Once I touch the
> > break point (this process/thread will be suspended)---BUT,other
> > process/thread are still in normal status .Soon ,these process/threads
> > will be suspended one after another because they are  waiting the
> > feedback come from the process/thread which are bing debugged
> > .Unfortunately,when I continue the process/threads, the process/thread
> > can't return to the orginial status because other processes /threads are
> > in error status (time out etc.)
> > How to "freeze" the whole "user mode linux" --all processes/threads in
> > "UML"and "UML" kernel even "UML" system timer!!!
> > and, how to recover it???
uml_mconsole <the umid of the instance>

To suspend a UML instance, at the prompt use "stop" and "go". I'm not at all 
sure you can gdb the UML instance meanwhile... but especially it will suspend 
any I/O you can do, and I think every process inside the UML instance, 
including gdb.

> Does swsusp work under UML? :)
Maybe, Nigel Cunningham, the developer of Swsusp 2 come by sometimes on this 
list.

For swsusp, I don't know at all what would be needed.
In the archives there was also an announce for a separate project for UML only 
to implement suspending in a UML-specific way (it was meaningful, but I don't 
remember about it, even because they wanted to run their own mainling list).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
