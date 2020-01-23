Return-Path: <brendanhiggins@google.com>
MIME-Version: 1.0
References: <20191210212108.222514-1-brendanhiggins@google.com>
 <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>
 <CAFLxGvzMf1Fni4va1EM1ta_o7zDjkM8iAr=j+t74+G79wq=XOA@mail.gmail.com> <c80a1c56a5a543d2a7174e598919164aSN6PR10MB3039E2FB633AC95CF4279B04E2320@SN6PR10MB3039.namprd10.prod.outlook.com>
In-Reply-To: <c80a1c56a5a543d2a7174e598919164aSN6PR10MB3039E2FB633AC95CF4279B04E2320@SN6PR10MB3039.namprd10.prod.outlook.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 23 Jan 2020 15:25:49 -0800
Message-ID: <CAFd5g45oZrj4MRQzJhujr1pVbOjjcqukAxm3NWTRPwO78UaidA@mail.gmail.com>
Subject: Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
Content-Type: text/plain; charset="UTF-8"
To: James McMechan <james_mcmechan@hotmail.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Johannes Berg <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "davidgow@google.com" <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
List-ID: <linux-um.lists.infradead.org>

On Sun, Jan 19, 2020 at 4:30 PM James McMechan
<james_mcmechan@hotmail.com> wrote:
>
> Resent for the mailing list since my webmail decided to try to send html...
>
> I agree that at least the UML_NET_VECTOR is not compatible with static linking at the moment,
> but I was running a statically linked UML with PCAP back in December.
> I was having no problems, but I don't remember if I was using PCAP itself...

I was just going off of what Anton and Johannes said in regard to
PCAP; it seems to have deviated from the libpcap library, so I have
been unable to test it:

http://lists.infradead.org/pipermail/linux-um/2019-December/002548.html

Anton, do you have the fix for PCAP out yet?

> I seem to remember a minor patch I did to fix a symbol conflict but nothing of note.
> I have not played around with UML_NET_VECTOR since I run the normal networking.
> And I did not find any config info with a quick googling the vector version so I just ignored it.

Nevertheless, VDE still causes the linker to complain.

Cheers

