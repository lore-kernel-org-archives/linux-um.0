Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXoCe-00036r-Hi	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 15:36:48 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DXnZO-0008CK-Pz	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 14:58:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Uploaded new version of the test program and x86-64
	SKAS patch working with it
References: <200505162020.19993.blaisorblade@yahoo.it>
	<4288ED62.8070007@tuxrocks.com>
In-Reply-To: <4288ED62.8070007@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505162328.49471.blaisorblade@yahoo.it>
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
Date: Mon, 16 May 2005 23:28:49 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Frank Sorenson <frank@tuxrocks.com>, Jeff Dike <jdike@addtoit.com>

On Monday 16 May 2005 20:58, Frank Sorenson wrote:
> Blaisorblade wrote:
> > First: the new SKAS patch does not yet support UML. However, it should
> > support both modes for the test program. Jeff, I guess you might want to
> > take a look at it (I'm working on this too).
>
> Blaisorblade,
>
> Thanks for working on the SKAS patch.
>
> Question.  Are you saying that skas-2.6.12-rc4-v9-pre4 doesn't work yet,
> or just doesn't work on x86-64? 
The second one.
> For x86, should we stick with -pre2 for 
> now, or should -pre4 be stable?
For x86 there should be no visible changes, and if there are any that's a bug. 
So stick with -pre2 (or even with -V8, since pre-release means pre-release).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
