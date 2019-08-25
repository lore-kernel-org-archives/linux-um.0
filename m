Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alex Dewar <alex.dewar@gmx.co.uk>
Subject: [PATCH 0/4] Add SPDX headers for most files in arch/um
Date: Sun, 25 Aug 2019 10:49:15 +0100
Message-Id: <20190825094919.4731-1-alex.dewar@gmx.co.uk>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Most files in arch/um have "Licensed under the GPL" in comments at the
top. Convert to use SPDX headers. I've broken these changes into a
patch series even though they're effectively one logical change,
because the diff was >1700 lines. I can resend as a single patch if
preferred.

There are some remaining files where there was no comment indicating
what the license was, so I haven't added SPDX tags for those (though
presumably they're also GPLv2 -- I can add tags for them in a
separate patch if you like).

The remaining files without SPDX tags are:
arch/um/kernel/asm-offsets.c
arch/um/kernel/dyn.lds.S
arch/um/kernel/vmlinux.lds.S
arch/um/include/shared/mem_user.h
arch/um/include/asm/vmlinux.lds.h
arch/um/include/asm/unwind.h
arch/um/include/asm/kvm_para.h
arch/um/include/asm/asm-prototypes.h
arch/um/os-Linux/execvp.c
arch/um/configs/x86_64_defconfig
arch/um/configs/i386_defconfig
arch/um/drivers/random.c
arch/um/drivers/harddog_kern.c



