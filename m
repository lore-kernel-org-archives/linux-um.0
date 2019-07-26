Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hr8Q9-0002T6-4P
 for linux-um@lists.infradead.org; Fri, 26 Jul 2019 22:10:38 +0000
Received: by mail-wr1-f66.google.com with SMTP id f9so55793338wre.12
 for <linux-um@lists.infradead.org>; Fri, 26 Jul 2019 15:10:34 -0700 (PDT)
Subject: Re: [PATCH] Documentation: move Documentation/virtual to
 Documentation/virt
References: <20190724072449.19599-1-hch@lst.de>
 <b9baabbb-9e9b-47cf-f5a8-ea42ba1ddc25@redhat.com>
 <20190724120005.31a990af@lwn.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be4ba4a7-a21b-8c56-4517-8886a754ff55@redhat.com>
Date: Sat, 27 Jul 2019 00:10:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190724120005.31a990af@lwn.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, richard@nod.at, jdike@addtoit.com, rkrcmar@redhat.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, anton.ivanov@cambridgegreys.com

On 24/07/19 20:00, Jonathan Corbet wrote:
>  - kvm/api.txt pretty clearly belongs in the userspace-api book, rather
>    than tossed in with:
> 
>  - kvm/review-checklist.txt, which belongs in the subsystem guide, if only
>    we'd gotten around to creating it yet, or
> 
>  - kvm/mmu.txt, which is information for kernel developers, or
> 
>  - uml/UserModeLinux-HOWTO.txt, which belongs in the admin guide.
> 
> I suspect that organization is going to be one of the main issues to talk
> about in Lisbon.  Meanwhile, I hope that this rename won't preclude
> organizational work in the future.

Absolutely not, this rename was just about a badly-named directory.  I
totally agree with the above reorganization.  Does the userspace API
cover only syscall or perhaps sysfs interfaces?   There are more API
files (amd-memory-encryption.txt, cpuid.txt, halt-polling.txt msr.txt,
ppc-pv.txt, s390-diag.txt) but, with the exception of
amd-memory-encryption.txt and halt-polling.txt, they cover the
emulated-hardware interfaces that KVM provides to virtual machines.

Paolo

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

