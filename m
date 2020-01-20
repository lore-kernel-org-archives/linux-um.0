Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-co1nam11olkn2019.outbound.protection.outlook.com
 ([40.92.18.19] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itKxr-0001QQ-Dz
 for linux-um@lists.infradead.org; Mon, 20 Jan 2020 00:30:48 +0000
From: James McMechan <james_mcmechan@hotmail.com>
Subject: Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
Date: Mon, 20 Jan 2020 00:30:41 +0000
Message-ID: <c80a1c56a5a543d2a7174e598919164aSN6PR10MB3039E2FB633AC95CF4279B04E2320@SN6PR10MB3039.namprd10.prod.outlook.com>
References: <20191210212108.222514-1-brendanhiggins@google.com>
 <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>,
 <CAFLxGvzMf1Fni4va1EM1ta_o7zDjkM8iAr=j+t74+G79wq=XOA@mail.gmail.com>
In-Reply-To: <CAFLxGvzMf1Fni4va1EM1ta_o7zDjkM8iAr=j+t74+G79wq=XOA@mail.gmail.com>
Content-Language: en-US
Content-ID: <861E0265B588E5499AC32E3EDCC58493@namprd10.prod.outlook.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard.weinberger@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Johannes Berg <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "davidgow@google.com" <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Resent for the mailing list since my webmail decided to try to send html...

I agree that at least the=A0UML_NET_VECTOR is not compatible with static li=
nking at the moment,
but I was running a statically linked UML with PCAP back in December.=A0
I was having no problems, but I don't remember if I was using PCAP itself...
I seem to remember a minor patch I did to fix a symbol conflict but nothing=
 of note.
I have not played around with=A0UML_NET_VECTOR since I run the normal netwo=
rking.
And I did not find any config info with a quick googling the vector version=
 so I just ignored it.

Enjoy.

Jim McMechan



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

