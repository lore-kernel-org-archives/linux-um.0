Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4CBB4D4F.8010904@cs.helsinki.fi>
References: <1287242638-20968-1-git-send-email-richard@nod.at>
	<4CBB4D4F.8010904@cs.helsinki.fi>
Date: Mon, 18 Oct 2010 21:58:53 +0300
Message-ID: <AANLkTinPG1J280HMDkg4bhO-9evW2T86c8FKfhk84ZhR@mail.gmail.com>
Subject: Re: [PATCH 1/1] um: fix global timer issue when using CONFIG_NO_HZ
From: Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Richard Weinberger <richard@nod.at>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, arjan@linux.intel.com, peterz@infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Oct 17, 2010 at 10:23 PM, Pekka Enberg <penberg@cs.helsinki.fi> wro=
te:
> On 16.10.2010 18.23, Richard Weinberger wrote:
>>
>> This fixes a issue which was introduced by fe2cc53e.
>> timeval_to_ns() returns long long and not int.
>> Due to that UML's timer did not work proper and caused timer freezes.
>>
>> LKML-Reference:<AANLkTik5_TCXeGzTWBZzE8F0Cb2bQq-D228xDXk87rhP () mail !
>> gmail ! com>
>> Signed-off-by: Richard Weinberger<richard@nod.at>
>> ---
>> =EF=BF=BDarch/um/os-Linux/time.c | =EF=BF=BD =EF=BF=BD2 +-
>> =EF=BF=BD1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
>> index dec5678..6e3359d 100644
>> --- a/arch/um/os-Linux/time.c
>> +++ b/arch/um/os-Linux/time.c
>> @@ -60,7 +60,7 @@ static inline long long timeval_to_ns(const struct
>> timeval *tv)
>> =EF=BF=BDlong long disable_timer(void)
>> =EF=BF=BD{
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDstruct itimerval time =3D ((struc=
t itimerval) { { 0, 0 }, { 0, 0 }
>> });
>> - =EF=BF=BD =EF=BF=BD =EF=BF=BD int remain, max =3D UM_NSEC_PER_SEC / UM=
_HZ;
>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD long long remain, max =3D UM_NSEC_PER_SE=
C / UM_HZ;
>>
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDif (setitimer(ITIMER_VIRTUAL,&tim=
e,&time)< =EF=BF=BD0)
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BDprintk(UM_KERN_ERR "disable_timer - setitimer failed, "
>
> Acked-by: Pekka Enberg <penberg@kernel.org>

Andrew, do you mind picking this patch up?
