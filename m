Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ms.lwn.net ([45.79.88.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hs685-0002J5-38
 for linux-um@lists.infradead.org; Mon, 29 Jul 2019 13:55:58 +0000
Date: Mon, 29 Jul 2019 07:55:54 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: move Documentation/virtual to
 Documentation/virt
Message-ID: <20190729075554.46dfaaeb@lwn.net>
In-Reply-To: <be4ba4a7-a21b-8c56-4517-8886a754ff55@redhat.com>
References: <20190724072449.19599-1-hch@lst.de>
 <b9baabbb-9e9b-47cf-f5a8-ea42ba1ddc25@redhat.com>
 <20190724120005.31a990af@lwn.net>
 <be4ba4a7-a21b-8c56-4517-8886a754ff55@redhat.com>
MIME-Version: 1.0
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, richard@nod.at, jdike@addtoit.com, rkrcmar@redhat.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, anton.ivanov@cambridgegreys.com

On Sat, 27 Jul 2019 00:10:32 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Does the userspace API
> cover only syscall or perhaps sysfs interfaces?   There are more API
> files (amd-memory-encryption.txt, cpuid.txt, halt-polling.txt msr.txt,
> ppc-pv.txt, s390-diag.txt) but, with the exception of
> amd-memory-encryption.txt and halt-polling.txt, they cover the
> emulated-hardware interfaces that KVM provides to virtual machines.

The user-space API certainly goes beyond system calls.  For sysfs, I
guess, the question would be whether a given knob is something that an
application would use (userspace-api) or something that a sysadmin would
want to tweak (admin-guide).

Thanks,

jon

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

