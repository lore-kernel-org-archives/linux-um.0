Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRurQ-0001a2-0D for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:07:20 -0700
Received: from aa011msr.fastwebnet.it ([85.18.95.71])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRurO-0007jJ-At
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:07:19 -0700
Date: Mon, 25 Sep 2006 20:07:08 +0200
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20060925180707.GA5039@inferi.kami.home>
References: <20060924114638.GB27881@inferi.kami.home>
	<200609242119.17741.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200609242119.17741.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.18 SKAS patch fails to apply (1 failed HUNK)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Sep 24, 2006 at 09:19:17PM +0200, Blaisorblade wrote:
> On Sunday 24 September 2006 13:46, Mattia Dongili wrote:
> > Hello Paolo,
> >
> > with the following change the patch applies and hopefully works, still
> > building here but mm/fremap.o is done so I'm quite optimistic :) (__prot
> > is used in the code, not prot).
> Ok, ok, I'm doing a production release... (I used some freedom in that one, 
> since it was a developer release). Or better, two production releases.
> One normal one, and another with full RFP support.

great! thanks

> As explained in the news page, the patch _requires_ the separate 
> Remap_File_Pages patch (it was an experimental release); I should have 

ooops :) it seems it's my time to "doh!"... /me is too lazy sometimes, I
had your archive bookmarked and just took the first 2.6.18-something I
saw.

> suggested that you can simply split away the last patch in series to remove 
> the dependency. Plus some requested fixups on configuration items (deprecate 
> TT mode for instance).
> 
> Additionally, I'm releasing -bb1: quite a lot of improvements for locking, 
> especially on UBD, but also on UML networking drivers, and on helpers 
> execution, and experimental TLS x86_64 support.

this is great, TLS/64 is what is keeping me from supplying amd64 UML
images for debian. I'll probably try to get the patch there and finally
push amd64 images.

thanks again
-- 
mattia
:wq!

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
