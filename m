Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cwn5m-0007Vu-0G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 11:56:42 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cwn5k-0006ec-Ak for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 11:56:41 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS3: prerelease of V8 (against 2.6.9) uploaded
References: <200501290036.51182.blaisorblade@yahoo.it>
	<41FF9FA7.3000500@tuxrocks.com>
	<08a901c5087a$fabe3950$0201a8c0@hawk>
In-Reply-To: <08a901c5087a$fabe3950$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502032055.49880.blaisorblade@yahoo.it>
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
Date: Thu, 3 Feb 2005 20:55:49 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>, Doug Dumitru <doug@easyco.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Frank Sorenson <frank@tuxrocks.com>, Rob Landley <rob@landley.net>

On Tuesday 01 February 2005 17:27, you wrote:
> With the problems we had with 2.6.9 as a host, I was wondering why
> Blaisorblade chose it when he released skas-v8-rc1.

I wondered too :-), however the reason was just that I wanted to get it out 
for early review... I've then been busy and now I'm going to port it to 
2.6.10.

> Here is skas-v8-rc1 diffed against 2.6.10:

> http://www.theshore.net/~caker/patches/skas-v8-rc1-2.6.10.patch
I'm having a look at it, however IIRC there weren't too many subtle ptrace 
change in 2.6.10, so I guess you've done it well...

Actually I have some doubt about ptrace.c, for this part:

                  child->exit_code = data;
  -               /* make sure the single step bit is not set. */
  -               clear_singlestep(child);
  +               put_stack_long(child, EFL_OFFSET,tmp);
                  wake_up_process(child);
                  ret = 0;
                  break;

I understand the purpose, and it makes sense... but I'll have to find a way to 
clean it up... 
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
