Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrxYD-000096-0N for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 04:06:05 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CrxY9-0000aM-Bz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 04:06:04 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML - Is it using swap space?
References: <41F0A6F3.4030109@printsoft.com>
In-Reply-To: <41F0A6F3.4030109@printsoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211318.16207.blaisorblade@yahoo.it>
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
Date: Fri, 21 Jan 2005 13:18:15 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerhard Hannemann <gerhard.hannemann@printsoft.com>

On Friday 21 January 2005 07:53, Gerhard Hannemann wrote:
> Why does it seem that my UML does is not using its swap space?
I don't think that this is related to UML itself. I describe the most common 
possibility below, which is a general Linux VM behaviour, but I don't know if 
you are experiencing what I describe - run the check I suggest and you'll 
verify if I guessed right or wrong.

If I'm right, then UML is simply not using its swap because there is no reason 
to use it. And no, 1M of free memory is not always a good one. Read on to 
understand why.
> The memory usage drops down to just 1M
The free memory, right? Well, probably it's just cached data.
> yet tools such as 
> top and free never indcate that any swap space is ever being used.
> I provide the UML with a 512M swap_fs file and swapon -s
> seems to indicate that its available.
Well, why should Linux use the swap if there's free memory? Free memory is 
unused memory, i.e. keeping memory free is mostly useless. It's better to use 
it as file cache. So even a machine without running processes can have only 
1M free, and the rest filled by cache data. And such a machine will never use 
its swap. (Swapping the file cache is brain-damaged, normally).

Look at the "free" output on the 2nd line:

-/+ buffers/cache: .... ....

It is the important one - it counts the memory which is used excluding the 
file cache. And it allows you to see if what I described is your situation or 
not.

However, the real problem would be if with free swap space the system went 
OOM, which is not your case... it happened with the 2.6.9 kernel - because of 
one VM bug (described on lwn.net/Kernel).

But you said in the other message you run a 2.4.27 UML, so it's not your case. 
(The host kernel being 2.6.9 is unrelated to the swapping inside the guest).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
