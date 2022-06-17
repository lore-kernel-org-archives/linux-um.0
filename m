Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2KaN-009RZG-SK
	for linux-um@lists.infradead.org; Fri, 17 Jun 2022 22:37:06 +0000
Date: Sat, 18 Jun 2022 06:36:00 +0800
From: kernel test robot <lkp@intel.com>
Subject: [linux-next:master] BUILD REGRESSION
 07dc787be2316e243a16a33d0a9b734cd9365bd3
Message-ID: <62ad01d0.+Kbzg4vMb3zc9QYp%lkp@intel.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-xfs@vger.kernel.org, linux-um@lists.infradead.org, linux-staging@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, amd-gfx@lists.freedesktop.org, Linux Memory Management List <linux-mm@kvack.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 07dc787be2316e243a16a33d0a9b734cd9365bd3  Add linux-next specific files for 20220617

Error/Warning reports:

https://lore.kernel.org/lkml/202206071511.FI7WLdZo-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/xtensa/kernel/entry.S:461: undefined reference to `context_tracking_user_exit'
arch/xtensa/kernel/entry.S:548: undefined reference to `context_tracking_user_enter'
kernel/bpf/helpers.c:1490:29: sparse: sparse: symbol 'bpf_dynptr_from_mem_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1516:29: sparse: sparse: symbol 'bpf_dynptr_read_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1542:29: sparse: sparse: symbol 'bpf_dynptr_write_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1569:29: sparse: sparse: symbol 'bpf_dynptr_data_proto' was not declared. Should it be static?
xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0x24): undefined reference to `context_tracking_user_enter'
xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0x8): undefined reference to `context_tracking_user_exit'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9143:27: warning: variable 'abo' set but not used [-Wunused-but-set-variable]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- alpha-randconfig-r035-20220617
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- arm-randconfig-r005-20220617
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- i386-randconfig-a005
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- i386-randconfig-m021
|   `-- arch-x86-events-core.c-init_hw_perf_events()-warn:missing-error-code-err
|-- i386-randconfig-s001
|   |-- drivers-pci-pci.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-pci_power_t-assigned-usertype-state-got-int
|   |-- drivers-vfio-pci-vfio_pci_config.c:sparse:sparse:restricted-pci_power_t-degrades-to-integer
|   `-- kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-lockdep_map-const-lock-got-struct-lockdep_map-noderef-__rcu
|-- i386-randconfig-s002
|   |-- drivers-pci-pci.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-pci_power_t-assigned-usertype-state-got-int
|   |-- fs-xfs-xfs_file.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-vm_fault_t-usertype-ret-got-int
|   `-- kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-lockdep_map-const-lock-got-struct-lockdep_map-noderef-__rcu
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- ia64-allyesconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- m68k-allmodconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- m68k-allyesconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- m68k-randconfig-s031-20220617
|   |-- drivers-pci-pci.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-pci_power_t-assigned-usertype-state-got-int
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_data_proto-was-not-declared.-Should-it-be-static
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_from_mem_proto-was-not-declared.-Should-it-be-static
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_read_proto-was-not-declared.-Should-it-be-static
|   `-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_write_proto-was-not-declared.-Should-it-be-static
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- nios2-allyesconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- s390-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|-- sh-allmodconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- um-i386_defconfig
|   `-- arch-um-kernel-skas-uaccess.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-addr-got-unsigned-int-noderef-usertype-__user-uaddr
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- x86_64-randconfig-m001
|   `-- arch-x86-events-core.c-init_hw_perf_events()-warn:missing-error-code-err
|-- xtensa-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
`-- xtensa-randconfig-r033-20220617
    |-- arch-xtensa-kernel-entry.S:undefined-reference-to-context_tracking_user_enter
    |-- arch-xtensa-kernel-entry.S:undefined-reference-to-context_tracking_user_exit
    |-- xtensa-linux-ld:arch-xtensa-kernel-entry.o:(.text):undefined-reference-to-context_tracking_user_enter
    `-- xtensa-linux-ld:arch-xtensa-kernel-entry.o:(.text):undefined-reference-to-context_tracking_user_exit

clang_recent_errors
`-- hexagon-randconfig-r045-20220617
    `-- drivers-ufs-host-tc-dwc-g210-pltfrm.c:warning:unused-variable-tc_dwc_g210_pltfm_match

elapsed time: 902m

configs tested: 113
configs skipped: 4

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                           corgi_defconfig
m68k                         apollo_defconfig
m68k                           virt_defconfig
m68k                        stmark2_defconfig
mips                        vocore2_defconfig
mips                         rt305x_defconfig
powerpc                    adder875_defconfig
m68k                         amcore_defconfig
openrisc                 simple_smp_defconfig
arm                            zeus_defconfig
arm                             ezx_defconfig
m68k                            q40_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                    xip_kc705_defconfig
parisc                generic-32bit_defconfig
sh                           sh2007_defconfig
m68k                       m5249evb_defconfig
powerpc                   motionpro_defconfig
sparc                            allyesconfig
arm                          badge4_defconfig
sh                             espt_defconfig
arm                           h3600_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220617
s390                 randconfig-r044-20220617
riscv                randconfig-r042-20220617
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func

clang tested configs:
arm                           sama7_defconfig
mips                      malta_kvm_defconfig
arm                          collie_defconfig
riscv                             allnoconfig
arm                       cns3420vb_defconfig
powerpc                      acadia_defconfig
mips                          ath79_defconfig
arm                      pxa255-idp_defconfig
arm                         s5pv210_defconfig
hexagon                             defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220617
hexagon              randconfig-r045-20220617

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

