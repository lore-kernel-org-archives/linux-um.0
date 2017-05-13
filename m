Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1d9UDY-0006If-5n
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 10:24:08 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d9UDX-0006vy-7c
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 10:24:08 +0000
References: <20170513101046.Horde.P7MZvg1O0xNi0CnTODsXRIH@webmail.your-server.de>
	<CAFLxGvyoYQU0e+_pHMZ2k0S3mxNJt9xshN_hrNMAYiTVBLkmMA@mail.gmail.com>
From: Thomas Meyer <thomas@m3y3r.de>
Message-ID: <7ac6769e-9907-7c1d-d4c5-e70724a73866@m3y3r.de>
Date: Sat, 13 May 2017 12:24:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyoYQU0e+_pHMZ2k0S3mxNJt9xshN_hrNMAYiTVBLkmMA@mail.gmail.com>
Subject: Re: [uml-devel] userfaultfd for UML userspace processes
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am 13.05.2017 um 12:04 schrieb Richard Weinberger:
> Thomas,

Hi,

> On Sat, May 13, 2017 at 10:10 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
>>
>> Hi,
>>
>> after looking into using userfaultfd for the userspace UML process
>> page fault handling, I come to the conclusion that userfaultfd
>> *cannot* be used for above goal as it only operates on mmaped memory
>> areas.
>> Am I missing something? What do you think about it?
> 
> See: https://lkml.org/lkml/2015/5/20/541
Cool! Thanks for the hint. I don't follow LKML, so...

But Andrea wrote:

"Alternatively once we extend the handle_userfault to tmpfs you could
map the page in two virtual mappings and track the faults in one
mapping (where the tracked app runs) and read/write the page contents
in the other mapping that isn't tracked by the userfault."

I think this is now the case with 4.11, isn't it?

As I understand this we must do the following:

kernel process: Map a tmpfs region for each userspace process with 
read/write.
userspace process: Map the same tmpfs for the current process and 
userfaultfd the whole address space, and give the userfaultfd fd to the 
kernel somehow and process the page fault there and fill/copy the 
faulted page accordingly.

so each userspace process would be backed by a tmpfs mmap region? sound 
complicated.

with kind regards
thomas


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

