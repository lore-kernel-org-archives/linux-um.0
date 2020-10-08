Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQZYX-0000gY-94
 for linux-um@lists.infradead.org; Thu, 08 Oct 2020 17:18:18 +0000
Subject: Re: [RFC v7 00/21] Unifying LKL into UML
References: <cover.1600922528.git.thehajime@gmail.com>
 <cover.1601960644.git.thehajime@gmail.com>
 <1ba41b09-6bdb-2fb7-5696-7db429e0a6a5@cambridgegreys.com>
 <m2362o6hmv.wl-thehajime@gmail.com>
 <003d0714-3bb6-dc02-ba3d-0237f8c5f40c@cambridgegreys.com>
 <CAMoF9u1j3hO_+jYvFdVvowG6mAYM=yEBV4z2BjfyUB=zhrF-3g@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <9b618028-d333-dfe2-ab23-bc8f0da06832@cambridgegreys.com>
Date: Thu, 8 Oct 2020 18:18:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAMoF9u1j3hO_+jYvFdVvowG6mAYM=yEBV4z2BjfyUB=zhrF-3g@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Octavian Purdila <tavi.purdila@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Hajime Tazaki <thehajime@gmail.com>

On 08/10/2020 18:13, Octavian Purdila wrote:
> On Thu, Oct 8, 2020 at 3:50 PM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
>>
>> On 08/10/2020 13:12, Hajime Tazaki wrote:
>>> Hello Anton,
>>>
>>> On Wed, 07 Oct 2020 22:30:03 +0900,
>>> Anton Ivanov wrote:
>>>> On 06/10/2020 10:44, Hajime Tazaki wrote:
>>>>> This is another spin of the unification of LKL into UML.  Based on the
>>>>> discussion of v4 patchset, we have tried to address issue raised and
>>>>> rewrote the patchset from scratch.  The summary is listed in the
>>>>> changelog below.
>>>>>
>>>>> Although there are still bugs in the patchset, we'd like to ask your
>>>>> opinions on the design we changed.
>>>>>
>>>>> The milestone section is also updated: this patchset is for the
>>>>> milestone 1, though the common init API is still not implemented yet.
>>>>>
>>>>>
>>>>> Changes in rfc v7:
>>>>> - preserve `make ARCH=um` syntax to build UML
>>>>> - introduce `make ARCH=um UMMODE=library` to build library mode
>>>>> - fix undefined symbols issue during modpost
>>>>> - clean up makefiles (arch/um, tools/um)
>>>> Hi Hajime, hi Tavi,
>>>>
>>>> Our starting point should be that it does not break the existing build. It still does.
>>> I agree with the starting point.
>>>
>>>> If I build a "stock configuration" UML after applying the patchset
>>>> the resulting vmlinux is not executable.
>>> Ah, I confirmed the issue.
>>> I was only trying to make the `linux` binary compatible, not vmlinux.
>>>
>>> Because vmlinux is now build as a relocatable object, this is
>>> something we need to figure out if we wish to keep vmlinux executable.
>>>
>>> Do you think we should make vmlinux executable even if we have the
>>> file linux executable ? If yes, we will work on this to fix the issue.
>> In my opinion, any relocatable objects, etc should be clearly named - either .o, .so, etc depending on what they are. We should not try to reuse any of the existing files for a different purpose.
>>
>> I also agree with Johannes that we are not using the tools/ directory for its intended purpose.
>>
>> We are not trying to build a tool. We are trying to build a sub-architecture. IMHO, the build should use a subdirectory under arch/um.
>>
> Hi Anton, Johannes,
>
>  From strictly the UML point of view, I can see how this would be a
> sub-architecture build since we are doing both the kernel build and
> the UML binary as a single step.
>
> If we look at arch/um as just the kernel that enables many
> applications, just one of which it is uml, I believe it is cleaner to
> build specific applications elsewhere. That is why we proposed to do a
> two step build process: one that builds the kernel as a relocatable
> object and one that uses this object to build programs, shared
> libraries, etc. Besides allowing us to create multiple tools /
> applications it also makes it much easier to support multiple OSes or
> other environments (e.g. bare-metal applications). As you can see,
> this allowed us to remove the linker script for UML and instead just
> used the target compiler to build the executable.

I have no objection to the proposal. In fact I like it very much.

My only concern is that we end up with files which are named identically 
to already existing ones.

IMHO, the kernel relocatable object should be vmlinux.a or vmlinux.so or 
vmlinux.o. It should not replace an already existing file which behaves 
differently.

Brgds,

A.

>
> We have picked tools because it has the infrastructure to build
> programs, shared libraries, and it is the single place (AFAIK) where
> we don't link the code in there with the kernel binary.
>
> Thanks,
> Tavi
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

