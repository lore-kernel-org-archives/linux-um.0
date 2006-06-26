Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuuEY-0002bP-9I for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 09:46:46 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FuuEV-0000Il-ML
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 09:46:46 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 26 Jun 2006 18:45:54 +0200
References: <87sllyl2np.fsf@hades.wkstn.nix>
	<200606252133.41822.blaisorblade@yahoo.it>
	<87veqnhohe.fsf@hades.wkstn.nix>
In-Reply-To: <87veqnhohe.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606261845.55165.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] problems compiling 2.6.17 against glibc 2.4
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nix <nix@esperi.org.uk>, Jeff Dike <jdike@addtoit.com>

On Monday 26 June 2006 18:26, Nix wrote:
> On Sun, 25 Jun 2006, blaisorblade@yahoo.it spake:
> > On Sunday 25 June 2006 21:19, Nix wrote:
> >> On Sun, 25 Jun 2006, blaisorblade@yahoo.it announced authoritatively:
> >> > On Wednesday 21 June 2006 21:38, Nix wrote:
> >>
> >> [jmp_buf goes hidden]
> >>
> >> > I made the same thought, but no, they have *already* changed it.
> >> > Search for the message from Ulrich Drepper
> >>
> >> It's not easy to find it given that little info :(
> >
> > No working author search?
>
> sourceware.org/gcc.gnu.org ran out of space to support its mailing list
> archive search in mid-2005. I don't think this was ever fixed. AIUI you
> can only get search results from after that by using Google.
>
> (And it never supported author search anyway.)
Ok, I missed one important bit of info. Plus, MARC archives when searching for 
author don't support restricting to one ML. So, here's the link to the 
discussion within UML-devel. Which is just a pointer to the issue (he surely 
doesn't explain here the security issues).

http://marc.theaimsgroup.com/?t=113927900500002&r=1&w=2
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
