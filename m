Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F4nwR-0005ag-3r for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Feb 2006 15:32:43 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1F4nwL-0002AD-Q2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Feb 2006 15:32:43 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] new version of ubd-many and uml_mconsole
References: <BAY101-F378CFB5DBDD49226518EA3E2160@phx.gbl>
In-Reply-To: <BAY101-F378CFB5DBDD49226518EA3E2160@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602030030.38283.blaisorblade@yahoo.it>
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
Date: Fri, 3 Feb 2006 00:30:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: James McMechan <james_mcmechan@hotmail.com>

On Monday 30 January 2006 00:16, James McMechan wrote:

> I also noted the your V3 cow format does not comply with the 64bit
> alignment rules and
> the compiler should insert a 32bit pad, or you could try __packed but that
> should
> segfault a real 64bit machine I think AMD64/EMT64 may allow unaligned
> access still someday PPC64/SPARC64/IA64 might get user mode linux and 64
> bit machines used to be picky about things like that.

We're (going to) use __packed but the thing doesn't work well yet - it 
compiles and runs, but a 64-bit uml_moo with packed still produces wrong 
results - one compiled as a 32-bit one works.

If you have any idea on this that may help...

For the alignment problem the format is not so good, however we can cope with 
that by reading 4-byte at once and reassembling them - the kernel has 
precoded get_unaligned() APIs to do such work (they work 1 byte at a time I 
guess, however).

I'm currently busy with exams so I can't work on the problem right now, 
however I should to finish soon and get back here.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
____________________________________
Con Yahoo! Mail proteggi la tua casella di posta da virus e posta indesiderata
http://mail.yahoo.com




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
