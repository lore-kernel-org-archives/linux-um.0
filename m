Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CryJb-0002VY-Lr for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 04:55:03 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CryJZ-0005W0-04 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 04:55:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.11-rc1 ...
References: <20050121121532.GA22707@bytesex>
In-Reply-To: <20050121121532.GA22707@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211407.09896.blaisorblade@yahoo.it>
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
Date: Fri, 21 Jan 2005 14:07:08 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>

On Friday 21 January 2005 13:15, Gerd Knorr wrote:
>   Hi,
>
> Anyone looked at 2.6.11-rc1 for the host?  Some more ptrace cleanups
> happened there, and one of the changes conflicts with the sysemu code in
> the skas-v7 patch for 2.6.10.  To me it's not clear how to solve that
> conflict as I'm not familier with the sysemu stuff and how these tree
> trace flags (syscall, sysemu, singlestep) play together ...

> The conflicting changeset is attached below for reference.  There are
> also some more ptrace changes (for singlestep) which might need fixups
> in sysemu.

>   Gerd

I've already solved those conflict earlier on -rc1 (not tested) but I didn't 
polish it out yet... if you are in a hurry, I can finish it and post the 
result today on the ML. If not, I'll publish it later.
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
