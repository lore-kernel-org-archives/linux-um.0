Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GqA6i-0007RE-Ek for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Dec 2006 07:15:22 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user50734)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GqA6g-0002IY-PR
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Dec 2006 07:15:20 -0800
References: <8764d1aplt.fsf@hades.wkstn.nix>
	<200611291702.21439.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
Date: Fri, 01 Dec 2006 15:15:10 +0000
In-Reply-To: <200611291702.21439.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Wed,
	29 Nov 2006 17:02:20 +0100")
Message-ID: <877ixby7ep.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] PATCH [00/03]: allow building of UML with skas
	headers installed via `make headers_install'
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
Cc: user-mode-linux-devel@lists.sourceforge.net

On 29 Nov 2006, blaisorblade@yahoo.it verbalised:
> On Sunday 26 November 2006 22:02, Nix wrote:
>> However, other problems are so-far undescribed. There's one trivial one
>> (fixed in patch 3 in this series, should be uncontroversial).
> Agreed.

Oh good, that's the only one I was confident of.

>> And then there's this:
>>
>>   CC      arch/um/os-Linux/process.o
>> In file included from arch/um/include/skas_ptrace.h:12,
>>                  from arch/um/os-Linux/process.c:23:
>> arch/um/include/sysdep/skas_ptrace.h:9: error: redefinition of `struct
>> ptrace_faultinfo' arch/um/include/sysdep/skas_ptrace.h:14: error:
>> redefinition of `struct ptrace_ldt'
>
>> The problem is that I installed my host kernel's headers, and that
>> kernel has the skas patch installed, so the skas ptrace structures
>> are already defined in <asm/ptrace.h>. Thankfully it's guarded by a
>> #define that we can test, but even so we need to split that SKAS
>> section out into a new header. (diff attached, not gitted since
>> the SKAS part isn't maintained in git anyway.)
>
>> So the following patches are a terribly provisional way to fix this:
>> it works but it may not maintain the separation between skas and
>> mainline that you want.
> 
> You maybe refer to the problem that without SKAS in host headers the resulting 
> UML tree does not compile?

I *have* SKAS in the host headers. That's the problem (and it arguably
shouldn't be).

>                             Yes, it is a problem. You are trying to remove all 
> duplications, and probably you should avoid them. Define a macro to test with 
> a more reasonable name (say __UML_SKAS_SUPPORT ...).

OK, will do. I just thought that cutting the skas-ptrace stuff into its
own header, rather than duplicating pieces of it between arch/ and
include/um/, seemed more immediately reasonable.

-- 
`The main high-level difference between Emacs and (say) UNIX, Windows,
 or BeOS... is that Emacs boots quicker.' --- PdS

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
